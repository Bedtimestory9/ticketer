## TODO: `ls -a`
defmodule Ticketer.Ls do
  use DoIt.Command,
    description: "List ticket"

  option(:id, :integer, "ticket_id", alias: :i)
  option(:all, :boolean, "List all tickets", alias: :a, default: false)

  def run(_args, options, _extra) do
    id = Map.get(options, :id)
    all = Map.get(options, :all)

    cond do
      all == true ->
        list_all_tickets()

      id != nil ->
        list_ticket(id)

      true ->
        IO.puts "Usage: ls -i <id> OR ls -a"
        list_all_tickets()
    end
  end

  defp list_ticket(id) do
    url = "https://giddy-muddy-eagle.gigalixirapp.com/api/tickets/#{id}"

    case Req.get(url) do
      {:ok, %Req.Response{status: 200, body: %{"data" => ticket}}} ->
        IO.puts "Found Ticket: #{ticket["description"]} (Status: #{ticket["status"]})"

      {:ok, %Req.Response{status: 404}} ->
        IO.puts "Ticket ##{id} not found."

      {:error, _} ->
        IO.puts "Connection failed."
    end
  end

  defp list_all_tickets() do
    url = "https://giddy-muddy-eagle.gigalixirapp.com/api/tickets"
    case Req.get(url) do
      {:ok, %Req.Response{status: 200, body: %{"data" => tickets}}} ->
        IO.puts "--- All Tickets ---"
        Enum.each(tickets, fn t -> 
          IO.puts "##{t["id"]} [#{t["status"]}] - #{t["description"]}"
        end)
      _ ->
        IO.puts "Failed to fetch tickets."
    end
  end
end

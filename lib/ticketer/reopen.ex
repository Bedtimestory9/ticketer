defmodule Ticketer.Reopen do
  use DoIt.Command,
    description: "Reopen the ticket"

  argument(:id, :integer, "ticket_id")

  def run(%{id: id}, _, _) do
    url = "https://giddy-muddy-eagle.gigalixirapp.com/api/tickets/#{id}/reopen"
    body = %{}

    case Req.post(url, json: body) do
      {:ok, %Req.Response{status: 200, body: %{"data" => ticket}}} ->
        IO.puts("Success! Ticket ##{ticket["id"]} is now #{ticket["status"]}")

      {:ok, %Req.Response{status: 422, body: %{"error" => msg}}} ->
        IO.puts("Error: #{msg}")

      {:ok, %Req.Response{status: 404}} ->
        IO.puts("Error: Ticket ##{id} does not exist.")

      {:error, _} ->
        IO.puts("Check if your Phoenix server is running at #{url}")
    end
  end
end

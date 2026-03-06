defmodule Ticketer.Create do
  use DoIt.Command,
    description: "Create a ticket"

  argument(:desc, :string, "description")

  def run(%{desc: desc}, _, _) do
    url = "https://giddy-muddy-eagle.gigalixirapp.com/api/tickets"

    body = %{
      "ticket" => %{
        "description" => desc,
        "status" => "New"
      }
    }

    case Req.post(url, json: body) do
      {:ok, %Req.Response{status: 201, body: %{"data" => ticket}}} ->
      IO.puts("Success! Ticket ##{ticket["id"]} created: #{ticket["description"]}")

      {:ok, %Req.Response{status: 422, body: %{"errors" => errors}}} ->
      IO.puts("Validation Error: #{inspect(errors)}")

      {:error, _} ->
      IO.puts("Check if your Phoenix server is running at #{url}")
    end
  end
end

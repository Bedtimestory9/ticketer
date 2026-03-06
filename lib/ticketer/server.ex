defmodule Ticketer.Server do
  use GenServer

  @db_file "../../tickets.json"

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def create_ticket(desc) do
    GenServer.call(__MODULE__, {:create, desc})
  end

  def get_ticket(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def list_tickets() do
    GenServer.call(__MODULE__, :list_all)
  end

  @impl true
  def init(_) do
    {:ok, load_from_disk()}
  end

  @impl true
  def handle_call(:list_all, _from, state) do
    {:reply, Map.values(state), state}
  end

  @impl true
  def handle_call({:get, id}, _from, state) do
    {:reply, Map.get(state, id), state}
  end

  @impl true
  def handle_call({:create, desc}, _from, state) do
    id = generate_id(state)

    ticket = %{
      id: id,
      description: desc,
      status: "New"
    }

    new_state = Map.put(state, id, ticket)
    persist(new_state)

    {:reply, {:ok, ticket}, new_state}
  end

  defp persist(state) do
    json = state |> Map.values() |> Jason.encode!()

    File.write!(@db_file, json)
  end

  defp load_from_disk do
    if File.exists?(@db_file) do
      @db_file
      |> File.read!()
      |> Jason.decode!()
      |> Enum.map(fn tickets ->
        {tickets["id"],
         %{
           id: tickets["id"],
           description: tickets["description"],
           status: tickets["status"]
         }}
      end)
      |> Enum.into(%{})
    else
      %{}
    end
  end

  defp generate_id(state) do
    state
    |> Map.keys()
    |> Enum.max(fn -> 0 end)
    |> Kernel.+(1)
  end
end

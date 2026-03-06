defmodule TicketerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  setup_all do
    {:ok, _pid} = Ticketer.Server.start_link()

    Enum.each(1..6, fn i ->
      Ticketer.Server.create_ticket("Ticket #{i}")
    end)

    :ok
  end

  test "create ticket command prints the correct message" do
    args = %{desc: "test_task"}
    options = %{}
    context = %{}

    output =
      capture_io(fn ->
        Ticketer.Create.run(args, options, context)
      end)

    assert output == "Ticket test_task is created.\n"
  end

  test "list ticket command prints the correct message" do
    args = %{id: 2}
    options = %{}
    context = %{}

    output =
      capture_io(fn ->
        Ticketer.Ls.run(args, options, context)
      end)

    assert output == "Ticket 2 is listed.\n"
  end

  test "wip ticket command prints the correct message" do
    args = %{id: 3}
    options = %{}
    context = %{}

    output =
      capture_io(fn ->
        Ticketer.Wip.run(args, options, context)
      end)

    assert output == "Ticket 3 is working in progress.\n"
  end

  test "close ticket command prints the correct message" do
    args = %{id: 4}
    options = %{}
    context = %{}

    output =
      capture_io(fn ->
        Ticketer.Close.run(args, options, context)
      end)

    assert output == "Ticket 4 is closed.\n"
  end

  test "complete ticket command prints the correct message" do
    args = %{id: 5}
    options = %{}
    context = %{}

    output =
      capture_io(fn ->
        Ticketer.Complete.run(args, options, context)
      end)

    assert output == "Ticket 5 is completed.\n"
  end

  test "reopen ticket command prints the correct message" do
    args = %{id: 6}
    options = %{}
    context = %{}

    output =
      capture_io(fn ->
        Ticketer.Reopen.run(args, options, context)
      end)

    assert output == "Ticket 6 is reopened.\n"
  end
end

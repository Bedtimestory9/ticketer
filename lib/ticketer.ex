defmodule Ticketer do
  use DoIt.MainCommand,
    description: "Ticketer CLI"

  command(Ticketer.Create)
  command(Ticketer.Ls)
  command(Ticketer.Wip)
  command(Ticketer.Close)
  command(Ticketer.Complete)
  command(Ticketer.Reopen)
end


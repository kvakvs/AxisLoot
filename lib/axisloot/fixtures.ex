defmodule Axisloot.Fixtures do
  @moduledoc "Fill the database with data for testing"
  alias Axisloot.Dbschema.LootHistory
  alias Axisloot.Dbschema.Raider
  alias Axisloot.Repo
  import Ecto.Query, warn: false

  defp raiders() do
    Repo.insert(%Raider{name: "Nar", joined: Date.utc_today()})
    Repo.insert(%Raider{name: "Camo", joined: Date.utc_today()})
    Repo.insert(%Raider{name: "Jun", joined: Date.utc_today()})
    Repo.insert(%Raider{name: "Spah", joined: Date.utc_today()})
    Repo.insert(%Raider{name: "Gula", joined: Date.utc_today()})
  end

  defp loot_history() do
    Repo.insert(%LootHistory{id: 1, event: "loot", text: "Grand Crown of Winning", raider_id: 1})
    Repo.insert(%LootHistory{id: 2, event: "loot", text: "Small Pants of Losing", raider_id: 2})
    Repo.insert(%LootHistory{id: 3, event: "loot", text: "Charm of the Commander", raider_id: 3})
    Repo.insert(%LootHistory{id: 4, event: "loot", text: "Super Mana Potion", raider_id: 4})
  end

  def fixtures() do
    raiders()
    loot_history()
  end
end

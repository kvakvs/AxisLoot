defmodule Axisloot.LootHistories do
  @moduledoc "Query helpers for loot history table"
  import Ecto.Query, warn: false
  alias Axisloot.Repo
  alias Axisloot.Dbschema.LootHistory

  def list_events() do
    Repo.all(LootHistory)
  end

  def list_events(opts) do
    from(m in LootHistory)
    |> sort(opts)
    |> Repo.all()
  end

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [:id, :event, :text, :who] and
              sort_dir in [:asc, :desc] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  defp sort(query, _opts), do: query

  #  @doc "Test data not for production, only call from iex"
  def fixtures() do
    Repo.insert(%LootHistory{id: 1, event: "loot", text: "Grand Crown of Winning", who: "Nar"})
    Repo.insert(%LootHistory{id: 2, event: "loot", text: "Small Pants of Losing", who: "Spah"})
    Repo.insert(%LootHistory{id: 3, event: "loot", text: "Charm of the Commander", who: "Camo"})
    Repo.insert(%LootHistory{id: 4, event: "loot", text: "Super Mana Potion", who: "Jun"})
  end
end

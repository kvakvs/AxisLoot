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
    |> filter(opts)
    |> sort(opts)
    |> Repo.all()
  end

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [:id, :event, :text, :who] and
              sort_dir in [:asc, :desc] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  defp sort(query, _opts), do: query

  defp filter(query, opts) do
    query
    |> filter_by_event(opts)
    |> filter_by_text(opts)
    |> filter_by_who(opts)
  end

  # Optional add where event="" clause to query
  defp filter_by_event(query, %{event: ev}) when is_binary(ev) and ev != "" do
    where(query, event: ^ev)
  end

  defp filter_by_event(query, _opts), do: query

  defp filter_by_text(query, %{text: tx}) when is_binary(tx) and tx != "" do
    query_string = "%#{tx}%"
    where(query, [row], like(row.text, ^query_string))
  end

  defp filter_by_text(query, _opts), do: query

  defp filter_by_who(query, %{who: w}) when is_binary(w) and w != "" do
    query_string = "%#{w}%"
    where(query, [row], like(row.who, ^query_string))
  end

  defp filter_by_who(query, _opts), do: query

  @doc "Test data not for production, only call from iex"
  def fixtures() do
    Repo.insert(%LootHistory{id: 1, event: "loot", text: "Grand Crown of Winning", who: "Nar"})
    Repo.insert(%LootHistory{id: 2, event: "loot", text: "Small Pants of Losing", who: "Spah"})
    Repo.insert(%LootHistory{id: 3, event: "loot", text: "Charm of the Commander", who: "Camo"})
    Repo.insert(%LootHistory{id: 4, event: "loot", text: "Super Mana Potion", who: "Jun"})
  end
end

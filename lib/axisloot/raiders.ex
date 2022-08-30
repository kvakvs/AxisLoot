defmodule Axisloot.Raiders do
  @moduledoc "Query helpers for raiders table"
  import Ecto.Query, warn: false
  alias Axisloot.Repo
  alias Axisloot.Dbschema.Raider

  def list_raiders() do
    Repo.all(Raider)
  end

  def list_raiders(opts) do
    from(m in Raider)
    |> filter(opts)
    |> sort(opts)
    |> Repo.all()
  end

  def list_raiders_with_count(opts) do
    query = from(r in Raider) |> filter(opts)
    total_count = Repo.aggregate(query, :count)
    result = query |> sort(opts) |> paginate(opts) |> Repo.all()
    {:ok, result, total_count}
    %{values: result, total_count: total_count}
  end

  defp paginate(query, %{page: page, page_size: page_size})
       when is_integer(page) and is_integer(page_size) do
    offset = max(page - 1, 0) * page_size

    query
    |> limit(^page_size)
    |> offset(^offset)
  end

  defp paginate(query, _opts), do: query

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [:name, :token_type] and
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
end

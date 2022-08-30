defmodule AxislootWeb.RosterController do
  use AxislootWeb, :live_view
  alias AxislootWeb.Forms.RosterSortingForm
  alias AxislootWeb.Forms.RosterFilterForm
  alias AxislootWeb.Forms.PaginationForm
  alias Axisloot.Raiders

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    socket =
      socket
      |> parse_params(params)
      |> assign_roster()

    {:noreply, socket}
  end

  defp parse_params(socket, params) do
    with {:ok, sorting_opts} <- RosterSortingForm.parse(params),
         {:ok, filter_opts} <- RosterFilterForm.parse(params),
         {:ok, pagination_opts} <- PaginationForm.parse(params) do
      socket
      |> assign_sorting(sorting_opts)
      |> assign_filter(filter_opts)
      |> assign_pagination(pagination_opts)
    else
      _error ->
        socket |> assign_sorting() |> assign_filter() |> assign_pagination()
    end
  end

  defp assign_pagination(socket, overrides \\ %{}) do
    assign(socket, :pagination, PaginationForm.default_values(overrides))
  end

  defp assign_sorting(socket, overrides \\ %{}) do
    merged_opts = RosterSortingForm.default_values(overrides)
    assign(socket, :sorting, merged_opts)
  end

  defp assign_filter(socket, overrides \\ %{}) do
    merged_opts = RosterFilterForm.default_values(overrides)
    assign(socket, :filter, merged_opts)
  end

  # Read the database of raiders
  defp assign_roster(socket) do
    params = merge_and_sanitize_params(socket)

    %{
      values: values,
      total_count: total_count
    } = Raiders.list_raiders_with_count(params)

    socket
    |> assign(:raiders, values)
    |> assign_total_count(total_count)
  end

  def render(assigns) do
    ~H"""
    <.live_component id="topnav" module={AxislootWeb.Live.PageSwitcherComp} from_page={:roster} />
    Roster
    """
  end

  def handle_event("nav_" <> event, _value, socket) do
    AxislootWeb.Live.PageSwitcherComp.handle_event(event, _value, socket)
  end

  defp merge_and_sanitize_params(socket, overrides \\ %{}) do
    %{
      sorting: sorting,
      filter: filter,
      pagination: pagination
    } = socket.assigns

    %{}
    |> Map.merge(sorting)
    |> Map.merge(filter)
    |> Map.merge(pagination)
    |> Map.merge(overrides)
    |> Map.drop([:total_count])
    |> Enum.reject(fn {_key, value} -> is_nil(value) end)
    |> Map.new()
  end

  defp assign_total_count(socket, total_count) do
    update_fn = fn pagination -> %{pagination | total_count: total_count} end
    update(socket, :pagination, update_fn)
  end
end

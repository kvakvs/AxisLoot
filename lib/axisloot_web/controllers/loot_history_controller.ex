defmodule AxislootWeb.LootHistoryController do
  use AxislootWeb, :live_view
  alias Axisloot.LootHistories
  alias AxislootWeb.Forms.EventSortingForm
  alias AxislootWeb.Forms.EventFilterForm
  alias AxislootWeb.Forms.PaginationForm

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    socket =
      socket
      |> parse_params(params)
      |> assign_loot_history()
      |> assign(:show_add_event_form, false)

    {:noreply, socket}
  end

  defp parse_params(socket, params) do
    with {:ok, sorting_opts} <- EventSortingForm.parse(params),
         {:ok, filter_opts} <- EventFilterForm.parse(params),
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
    merged_opts = EventSortingForm.default_values(overrides)
    assign(socket, :sorting, merged_opts)
  end

  defp assign_filter(socket, overrides \\ %{}) do
    merged_opts = EventFilterForm.default_values(overrides)
    assign(socket, :filter, merged_opts)
  end

  # Read the database of events
  defp assign_loot_history(socket) do
    params = merge_and_sanitize_params(socket)

    %{
      values: values,
      total_count: total_count
    } = LootHistories.list_events_with_count(params)

    socket
    |> assign(:loot_history, values)
    |> assign_total_count(total_count)
  end

  def render(assigns) do
    ~H"""
    <%= if @show_add_event_form do %>
       <button phx-click="hide-add-event">Hide form</button>
     <.live_component
        id={"add_event_form"}
        module={AxislootWeb.Live.AddEventFormComp} />
    <% else %>
      <button phx-click="show-add-event">Add event</button>
    <% end %>

    <.live_component
      module={AxislootWeb.Live.EventFilterComp}
      id="filter"
      filter={@filter} />

    <table>
    <thead>
    <tr>
      <th>
        <.live_component
          module={AxislootWeb.Live.EventSortingComp}
          id={"sorting-id"}
          key={:id}
          sorting={@sorting} />
      </th>
      <th>
        <.live_component
          module={AxislootWeb.Live.EventSortingComp}
          id={"sorting-event"}
          key={:event}
          sorting={@sorting} />
      </th>
      <th>
        <.live_component
          module={AxislootWeb.Live.EventSortingComp}
          id={"sorting-text"}
          key={:text}
          sorting={@sorting} />
      </th>
      <th>
        <.live_component
          module={AxislootWeb.Live.EventSortingComp}
          id={"sorting-who"}
          key={:who}
          sorting={@sorting} />
      </th>
      <th>created/upd</th>
    </tr>
    </thead>

    <tbody>
      <%= for ev <- @loot_history do %>
      <tr>
        <td><%= ev.id %></td>
        <td><%= ev.event %></td>
        <td><%= ev.text %></td>
        <td><%= ev.who %></td>
        <td class="smol12 gray">
          <div class="clear"><%= ev.inserted_at %></div>
          <div class="clear"><%= updated_at(ev) %></div>
        </td>
      </tr>
      <% end %>
    </tbody>
    </table>

    <.live_component
      module={AxislootWeb.Live.PaginationComponent}
      id="pagination"
      pagination={@pagination} />
    """
  end

  def updated_at(ev) do
    if ev.updated_at == ev.inserted_at, do: "", else: ev.updated_at
  end

  def handle_event("show-add-event", _value, socket) do
    {:noreply, assign(socket, :show_add_event_form, true)}
  end

  def handle_event("hide-add-event", _value, socket) do
    {:noreply, assign(socket, :show_add_event_form, false)}
  end

  def handle_info({:update, opts}, socket) do
    params = merge_and_sanitize_params(socket, opts)
    path = Routes.live_path(socket, __MODULE__, params)
    {:noreply, push_patch(socket, to: path, replace: true)}
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

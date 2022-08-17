defmodule AxislootWeb.LootPageController do
  use AxislootWeb, :live_view
  alias Axisloot.LootHistories
  alias AxislootWeb.Forms.SortingForm

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    socket =
      socket
      |> parse_params(params)
      |> assign_events()

    {:noreply, socket}
  end

  defp parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params) do
      assign_sorting(socket, sorting_opts)
    else
      _error ->
        assign_sorting(socket)
    end
  end

  defp assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)
    assign(socket, :sorting, opts)
  end

  @doc "Read the database of events"
  defp assign_events(socket) do
    %{sorting: sorting} = socket.assigns

    socket
    |> assign(:loot_history, LootHistories.list_events(sorting))
#    |> assign(:sorting, %{sort_by: :id, sort_dir: :desc})
  end

  def render(assigns) do
    ~H"""
    <table>

    <thead>
    <tr>
      <th>
        <.live_component
          module={AxislootWeb.Live.SortingComp}
          id={"sorting-id"}
          key={:id}
          sorting={@sorting} />
      </th>
      <th>
        <.live_component
          module={AxislootWeb.Live.SortingComp}
          id={"sorting-event"}
          key={:event}
          sorting={@sorting} />
      </th>
      <th>
        <.live_component
          module={AxislootWeb.Live.SortingComp}
          id={"sorting-text"}
          key={:text}
          sorting={@sorting} />
      </th>
      <th>
        <.live_component
          module={AxislootWeb.Live.SortingComp}
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
    """
  end

  def updated_at(ev) do
    if ev.updated_at == ev.inserted_at, do: "", else: ev.updated_at
  end

  def handle_info({:update, opts}, socket) do
    path = Routes.live_path(socket, __MODULE__, opts)
    {:noreply, push_patch(socket, to: path, replace: true)}
  end
end

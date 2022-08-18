defmodule AxislootWeb.Live.AddEventFormComp do
  @moduledoc "A pop-up form for adding events to the loot history"

  use AxislootWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      Form...
    </div>
    """
  end

  #  def handle_event("sort_by_key", _params, socket) do
  #    %{sorting: %{sort_dir: sort_dir}, key: key} = socket.assigns
  #
  #    sort_dir = if sort_dir == :asc, do: :desc, else: :asc
  #    new_sorting_opts = %{sort_by: key, sort_dir: sort_dir}
  #
  #    send(self(), {:update, new_sorting_opts})
  #    {:noreply, socket}
  #  end
end

defmodule AxislootWeb.Live.PageSwitcherComp do
  @moduledoc "A top navigation menu"
  use AxislootWeb, :live_component
  alias AxislootWeb.Forms.AddEventForm

  #  def mount(socket) do
  #  end

  def render(assigns) do
    ~H"""
    <div class="topbar">
      <button class={if @from_page == :roster, do: "active", else: ""}
        phx-click="nav_roster">
        Roster</button>
      <button class={if @from_page == :standings, do: "active", else: ""}
        phx-click="nav_standings">
        Standings</button>
      <button class={if @from_page == :attendance, do: "active", else: ""}
        phx-click="nav_attendance">
        Attendance</button>
      <button class={if @from_page == :loot_history, do: "active", else: ""}
        phx-click="nav_loot_history">
        Loot History</button>
    </div>
    """
  end

  def handle_event("roster", _assigns, socket) do
    {:noreply, redirect(socket, to: "/")}
  end

  def handle_event("standings", _assigns, socket) do
    {:noreply, redirect(socket, to: "/standings")}
  end

  def handle_event("attendance", _assigns, socket) do
    {:noreply, redirect(socket, to: "/attendance")}
  end

  def handle_event("loot_history", _assigns, socket) do
    {:noreply, redirect(socket, to: "/loot_history")}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

  def update(_upd, socket), do: {:ok, socket}
end

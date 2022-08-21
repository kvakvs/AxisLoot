defmodule AxislootWeb.RosterController do
  use AxislootWeb, :live_view

  def render(assigns) do
    ~H"""
    <.live_component id="topnav" module={AxislootWeb.Live.PageSwitcherComp} from_page={:roster} />
    Roster
    """
  end

  def handle_event("nav_" <> event, _value, socket) do
    AxislootWeb.Live.PageSwitcherComp.handle_event(event, _value, socket)
  end
end
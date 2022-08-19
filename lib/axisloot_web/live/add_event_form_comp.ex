defmodule AxislootWeb.Live.AddEventFormComp do
  @moduledoc "A pop-up form for adding events to the loot history"
  use AxislootWeb, :live_component
  alias AxislootWeb.Forms.AddEventForm

  def mount(socket) do
    socket = socket |> assign(:changeset, AddEventForm.change_values(%{}))
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form let={f} for={@changeset} as="add_event_form" phx-submit="search" phx-target={@myself} >
        <div class="row">
          <div class="w-15">
            <%= label f, :event %>
            <%= text_input f, :event %>
            <%= error_tag f, :event %>
          </div>
          <div class="w-15">
            <%= label f, :text %>
            <%= text_input f, :text %>
            <%= error_tag f, :text %>
          </div>
          <div class="w-15">
            <%= label f, :who %>
            <%= text_input f, :who %>
            <%= error_tag f, :who %>
          </div>
          <div style="margin: auto 0px 4px 8px">
            <%= submit "Add" %>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  def update(%{add_event_form: f}, socket) do
    socket = socket |> assign(:changeset, AddEventForm.change_values(f))
    {:ok, socket}
  end

  def update(_upd, socket), do: {:ok, socket}
end

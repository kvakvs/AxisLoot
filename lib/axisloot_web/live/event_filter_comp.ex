defmodule AxislootWeb.Live.EventFilterComp do
  @moduledoc "Filters for the event history"

  use AxislootWeb, :live_component
  alias AxislootWeb.Forms.EventFilterForm

  def render(assigns) do
    ~H"""
    <div>
      <.form let={f} for={@changeset} as="filter" phx-submit="search" phx-target={@myself} >
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
            <%= submit "Filter" %>
            <!--button phx-click="reset">Reset</button-->
          </div>
        </div>
      </.form>
    </div>
    """
  end

  def update(%{filter: filter}, socket) do
    {:ok, assign(socket, :changeset, EventFilterForm.change_values(filter))}
  end

#  def handle_event("reset", _, socket) do
#    {:ok, assign(socket, :changeset, EventFilterForm.default_values)}
#  end

  def handle_event("search", %{"filter" => filter}, socket) do
    case EventFilterForm.parse(filter) do
      {:ok, opts} ->
        send(self(), {:update, opts})
        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
end

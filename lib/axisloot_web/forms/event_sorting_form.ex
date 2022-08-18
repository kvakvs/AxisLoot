defmodule AxislootWeb.Forms.EventSortingForm do
  import Ecto.Changeset
  alias Axisloot.EctoHelper

  @fields %{
    sort_by: EctoHelper.enum([:id, :event, :text, :who]),
    sort_dir: EctoHelper.enum([:asc, :desc])
  }

  @default_values %{
    sort_by: :id,
    sort_dir: :asc
  }

  def parse(params) do
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def default_values(overrides \\ %{}) do
    Map.merge(@default_values, overrides)
  end
end

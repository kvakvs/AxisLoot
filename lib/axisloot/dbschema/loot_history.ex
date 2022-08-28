defmodule Axisloot.Dbschema.LootHistory do
  @moduledoc "Schema for loot history of notable loots"
  use Ecto.Schema
  import Ecto.Changeset

  schema "loot_history" do
    field :event, :string
    field :text, :string
    field :equipment_slot, Ecto.Enum, values: Axisloot.Const.equipment_slots()
    belongs_to :raider, Axisloot.Dbschema.Raider

    timestamps()
  end
end

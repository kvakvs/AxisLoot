defmodule Axisloot.Dbschema.Standings do
  @moduledoc "Schema for final calculated +BIS standings for each raider"
  use Ecto.Schema
  import Ecto.Changeset

  schema "standings" do
    belongs_to :raider, Axisloot.Dbschema.Raider

    belongs_to :head, Axisloot.Dbschema.LootHistory
    belongs_to :neck, Axisloot.Dbschema.LootHistory
    belongs_to :shoulder, Axisloot.Dbschema.LootHistory
    belongs_to :back, Axisloot.Dbschema.LootHistory
    belongs_to :chest, Axisloot.Dbschema.LootHistory
    belongs_to :wrist, Axisloot.Dbschema.LootHistory
    belongs_to :hands, Axisloot.Dbschema.LootHistory
    belongs_to :waist, Axisloot.Dbschema.LootHistory
    belongs_to :legs, Axisloot.Dbschema.LootHistory
    belongs_to :feet, Axisloot.Dbschema.LootHistory
    belongs_to :finger1, Axisloot.Dbschema.LootHistory
    belongs_to :finger2, Axisloot.Dbschema.LootHistory
    belongs_to :trinket, Axisloot.Dbschema.LootHistory
    belongs_to :trinket2, Axisloot.Dbschema.LootHistory
    belongs_to :main_hand, Axisloot.Dbschema.LootHistory
    belongs_to :off_hand, Axisloot.Dbschema.LootHistory
    belongs_to :ranged, Axisloot.Dbschema.LootHistory

    timestamps()
  end
end

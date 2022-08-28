defmodule Axisloot.Dbschema.Raider do
  @moduledoc "Schema for list of players"
  use Ecto.Schema

  schema "raider" do
    field :name, :string
    field :joined, :date
    has_many :loot_history, Axisloot.Dbschema.LootHistory
    has_one :standings, Axisloot.Dbschema.Standings

    timestamps()
  end
end

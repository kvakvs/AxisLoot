defmodule Axisloot.Dbschema.Attendance do
  @moduledoc "Schema for missed raids (opt-out), assuming raider has signed up if not signed out"
  use Ecto.Schema
  import Ecto.Changeset

  # Opt-out table
  schema "attendance" do
    field :raid_date, :date
    field :reason, :string
    belongs_to :raider, Axisloot.Dbschema.Raider

    timestamps()
  end
end

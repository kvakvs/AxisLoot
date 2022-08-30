defmodule :"Elixir.Axisloot.Repo.Migrations.Create-tables" do
  use Ecto.Migration

  def up do
    create table("raider") do
      add :name, :string
      add :joined, :date
      add :token_type, :string, size: 20

      timestamps()
    end

    create table("loot_history") do
      add :event, :string, size: 40
      add :text, :string
      add :equipment_slot, :string, size: 20
      add :raider_id, references(:raider)

      timestamps()
    end

    create table("standings") do
      add :raider_id, references(:raider)

      add :head, :integer
      add :neck, :integer
      add :shoulder, :integer
      add :back, :integer
      add :chest, :integer
      add :wrist, :integer
      add :hands, :integer
      add :waist, :integer
      add :legs, :integer
      add :feet, :integer
      add :finger1, :integer
      add :finger2, :integer
      add :trinket, :integer
      add :trinket2, :integer
      add :main_hand, :integer
      add :off_hand, :integer
      add :ranged, :integer

      timestamps()
    end
  end

  def down do
    drop table("loot_history")
    drop table("roster")
    drop table("standings")
  end
end

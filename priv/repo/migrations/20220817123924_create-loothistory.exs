defmodule :"Elixir.Axisloot.Repo.Migrations.Create-loothistory" do
  use Ecto.Migration

  def up do
    create table("loot_history") do
      add :event, :string, size: 40
      add :text, :string
      add :who, :string, size: 40

      timestamps()
    end
  end

  def down do
    drop table("loot_history")
  end
end

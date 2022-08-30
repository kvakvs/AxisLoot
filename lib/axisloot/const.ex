defmodule Axisloot.Const do
  @moduledoc false

  def token_types() do
    [
      # rogue, mage, druid, deathknight
      :vanquisher,
      # paladin, priest, warlock
      :conqueror,
      # hunter, shaman, warrior
      :protector
    ]
  end

  def token_type(c) when c == :rogue or c == :mage or c == :druid or c == :deathknight do
    :vanquisher
  end

  def token_type(c) when c == :paladin or c == :priest or c == :warlock do
    :conqueror
  end

  def token_type(c) when c == :hunter or c == :shaman or c == :warrior do
    :protector
  end

  def equipment_slots() do
    [
      :head,
      :neck,
      :shoulder,
      :back,
      :chest,
      :wrist,
      :hands,
      :waist,
      :legs,
      :feet,
      :finger,
      :trinket,
      :main_hand,
      :off_hand,
      :ranged
    ]
  end
end

class AddColumnNoWaterPulseReactionDelayToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :no_water_pulse_reaction_delay, :integer
  end
end

class AddSettingToSpriklers < ActiveRecord::Migration
  def change
    add_column :sprinklers, :main_valve_timing, :string, default: 'simultaneous'
    add_column :sprinklers, :main_valve_delay, :time
  end
end

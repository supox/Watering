class ChangeMainValfDalayToInt < ActiveRecord::Migration
  def up
    remove_column :sprinklers, :main_valve_delay
    add_column :sprinklers, :main_valve_delay, :integer, :default => 0
  end

  def down
  end
end

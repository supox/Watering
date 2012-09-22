class ChangeMainValfDalayToInt < ActiveRecord::Migration
  def up
    change_column :sprinklers, :main_valve_delay, :integer, :default => 0
  end

  def down
  end
end

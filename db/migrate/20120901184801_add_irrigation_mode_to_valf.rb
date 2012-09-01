class AddIrrigationModeToValf < ActiveRecord::Migration
  def change
    add_column :valves, :irrigation_mode, :string
  end
end

class AddValvesAndSensorsToSpriklers < ActiveRecord::Migration
  def change
    remove_column :sprinklers, :ios
  end
end

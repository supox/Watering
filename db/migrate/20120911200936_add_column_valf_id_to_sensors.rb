class AddColumnValfIdToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :valf_id, :integer
  end
end

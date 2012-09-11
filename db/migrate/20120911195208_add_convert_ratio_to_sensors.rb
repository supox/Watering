class AddConvertRatioToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :convert_ratio, :decimal
  end
end

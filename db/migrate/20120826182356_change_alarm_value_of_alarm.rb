class ChangeAlarmValueOfAlarm < ActiveRecord::Migration
  def up
    change_column :alarms, :alarm_value, :float
  end

  def down
    change_column :alarms, :alarm_value, :integer
  end
end

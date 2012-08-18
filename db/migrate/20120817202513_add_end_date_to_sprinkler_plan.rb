class AddEndDateToSprinklerPlan < ActiveRecord::Migration
  def change
    add_column :sprinkler_plans, :end_date, :datetime
  end
end

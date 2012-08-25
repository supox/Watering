class AddWateringTypeToSprinklerPlan < ActiveRecord::Migration
  def change
    add_column :sprinkler_plans, :plan_type, :string
  end
end

class AddAmoutToSprinklerPlanValves < ActiveRecord::Migration
  def change
    add_column :sprinkler_plan_valves, :amount, :decimal
  end
end

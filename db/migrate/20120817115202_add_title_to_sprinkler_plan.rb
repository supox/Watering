class AddTitleToSprinklerPlan < ActiveRecord::Migration
  def change
    add_column :sprinkler_plans, :title, :string
  end
end

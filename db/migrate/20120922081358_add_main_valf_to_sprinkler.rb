class AddMainValfToSprinkler < ActiveRecord::Migration
  def change
    add_column :sprinklers, :main_valf, :integer
  end
end

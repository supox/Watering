class AddValfTypeToValves < ActiveRecord::Migration
  def change
    add_column :valves, :valf_type, :string
  end
end

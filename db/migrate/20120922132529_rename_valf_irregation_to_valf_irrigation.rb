class RenameValfIrregationToValfIrrigation < ActiveRecord::Migration
  def up
    rename_table :valf_irregations, :valf_irrigations
  end

  def down
    rename_table :valf_irrigations, :valf_irregations
  end
end

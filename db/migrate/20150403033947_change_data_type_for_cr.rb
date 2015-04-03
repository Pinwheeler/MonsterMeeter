class ChangeDataTypeForCr < ActiveRecord::Migration
  change_column :Monsters, :cr, :float
end

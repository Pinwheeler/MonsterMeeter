class AddHostilityToMonsters < ActiveRecord::Migration
  def change
    add_column :monsters, :hostility, :float
  end
end

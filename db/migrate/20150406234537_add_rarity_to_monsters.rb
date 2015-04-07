class AddRarityToMonsters < ActiveRecord::Migration
  def change
    add_column :monsters, :normality, :float
  end
end

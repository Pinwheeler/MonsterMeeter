class CreateMonstersTerrains < ActiveRecord::Migration
  def change
    create_table :monsters_terrains, :id => false do |t|
        t.references :monster
        t.references :terrain
    end
    add_index :monsters_terrains, [:monster_id, :terrain_id]
    add_index :monsters_terrains, :terrain_id
  end
end

class AddTerrainRefToMonsters < ActiveRecord::Migration
  def change
    add_reference :monsters, :terrain, index: true
  end
end

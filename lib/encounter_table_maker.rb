require "rails_helper"

class EncounterTableMaker
    def initialize (terrains, party_cr)
        @terrains = terrains
        @party_cr = party_cr
    end
    
    def generate_array
        monster_pool = []
        @terrains.each do |terrain|
            terrain.monster_ids.each do |monster_id|
                monster_pool << Monster.find(monster_id) 
            end
        end
        total_array = []
        (0..15).each do |i|
            encounter_array = []
            monster_pool.each do |monster|
                if i <= 1
                    if monster.cr >= @party_cr * 2 
                        encounter_array << monster
                    end
                end
            end
            encounter_array << monster_pool[0]
            total_array << encounter_array
        end
        total_array
    end
end
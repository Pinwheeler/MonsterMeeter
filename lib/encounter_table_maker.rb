require "rails_helper"

class EncounterTableMaker
    def initialize (terrains, party_cr)
        @terrains = terrains
        @party_cr = party_cr
        @monster_pool = []
        @terrains.each do |terrain|
            terrain.monster_ids.each do |monster_id|
                @monster_pool << Monster.find(monster_id) 
            end
        end
    end
    
    def encounter_array_for_slot(i)
        encounter_array = []
        min_cr = @party_cr*0.8
        max_cr = @party_cr*1.2
        if i == 0
            min_cr = @party_cr * 2
            max_cr = @party_cr * 3
        end
        if i == 1
            min_cr = @party_cr * 1.5
            max_cr = @party_cr * 2.5
        end
        while overall_cr_for_monster_array(encounter_array) < min_cr do
            potential_monster = random_monster
            potential_array = encounter_array + [potential_monster]
            # puts "overall cr: #{overall_cr_for_monster_array(encounter_array)} max_cr:#{max_cr} min_cr:#{min_cr}"
            # puts "potential cr: #{overall_cr_for_monster_array(potential_array)} by adding monster: #{potential_monster}"
            if overall_cr_for_monster_array(potential_array) <= max_cr
                encounter_array << potential_monster 
            end
            
        end
        encounter_array
    end
    
    def random_monster
        @monster_pool[rand(@monster_pool.length)]
    end
    
    def generate_array
        total_array = []
        (0..15).each do |i|
            total_array << encounter_array_for_slot(i)
        end
        total_array
    end
    
    def overall_cr_for_monster_array(monster_array)
        if monster_array.length == 0
            return 0.0
        end
        raw_cr_sum = 0.0
        monster_array.each do |monster|
            raw_cr_sum += monster.cr
        end
        average_cr = raw_cr_sum / monster_array.length
        group_size_factor = (monster_array.length) * average_cr / 4 
        overall_cr = raw_cr_sum * group_size_factor
        # puts "Overall CR is: #{overall_cr}\n for encounter: #{monster_array}"
        overall_cr
    end
end
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
            while overall_cr_for_monster_array(encounter_array + [potential_monster]) <= max_cr
                encounter_array << potential_monster
                # puts encounter_array.inspect
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
        
        group_size_float = (monster_array.length / 10.0)
        overall_cr = raw_cr_sum + group_size_float
        # puts "Overall CR is: #{overall_cr}\n for encounter: #{monster_array}"
        overall_cr
    end
    
    def self.pretty_string_for_encounter(encounter_array)
        pretty_string = ""
        counts = Hash.new(0)
        encounter_array.each { |type| counts[type] += 1 }
        counts.each do |key, count|
            pretty_string += "#{count}x #{key.name}, " 
        end
        pretty_string[0...-2]
    end
end
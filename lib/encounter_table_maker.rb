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
        if i == 0 || i == 15
            min_cr = @party_cr * 2
            max_cr = @party_cr * 3
        end
        if i == 1 || i == 14
            min_cr = @party_cr * 1.5
            max_cr = @party_cr * 2.5
        end
        if i == 6 || i == 9
            min_cr = @party_cr * 0.5
            max_cr = @party_cr * 1.5
        end
        if i == 7 || i == 8
            min_cr = @party_cr * 0.1
            max_cr = @party_cr 
        end

        while overall_cr_for_monster_array(encounter_array) < min_cr do
            potential_monster = random_monster
            while overall_cr_for_monster_array(encounter_array + [potential_monster]) <= max_cr && monster_count_in_array(potential_monster, encounter_array) < 5
                encounter_array << potential_monster
                # puts encounter_array.inspect
            end
        end
        encounter_array
    end
    
    def encounter_table
        @encounter_table || generate_array
    end
    
    def random_monster
        srand
        @monster_pool[rand(@monster_pool.length)]
    end
    
    def generate_array
        total_array = []
        (0..15).each do |i|
            total_array << encounter_array_for_slot(i)
        end
        @encounter_table = total_array
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
    
    def monster_count_in_array(monster, array) 
        count = 0
        array.each do |counted_monster| 
            if monster == counted_monster
                count += 1
            end
        end
        count
    end
    
    def pretty_string_for_slot(i)
       self.pretty_string_for_encounter(encounter_array_for_slot(i)) 
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
    
    def self.xp_for_encounter(encounter_array)
        xp_total = 0
        encounter_array.each do |monster|
            xp_total += self.xp_for_cr(monster.cr) 
        end
        xp_total
    end
    
    #TODO: see if there's a formula for this (I don't think think that there is a nice one)
    def self.xp_for_cr(cr)
        case cr
        when 0
            10
        when 0.125
            25
        when 0.25
            50
        when 0.5
            100
        when 1
            200
        when 2
            450
        when 3
            700
        when 4
            1100
        when 5
            1800
        when 6
            2300
        when 7
            2900
        when 8
            3900
        when 9
            5000
        when 10
            5900
        when 11 
            7200
        when 12
            8400
        when 13
            10000
        when 14
            11500
        when 15
            13000
        when 16
            15000
        when 17
            18000
        when 18
            20000
        when 19
            22000
        when 20
            25000
        when 21
            33000
        when 22
            41000
        when 23
            50000
        when 24
            62000
        when 25
            75000
        when 26
            90000
        when 27
            105000
        when 28
            120000
        when 29
            135000
        when 30
            155000
        end
    end
end
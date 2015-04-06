require "encounter_table_maker"
require "rails_helper"



describe EncounterTableMaker do
    
    describe "generating the encounters" do
        
        context "when party CR is 4 and in an desert" do
            party_cr = 4.0
            desert = Terrain.find_by_name('Desert')
            maker =  EncounterTableMaker.new([desert], party_cr)
            encounters_array = maker.generate_array
            
            it "should create an array of exactly length 16" do
                (0..15).each do |i|
                    expect(encounters_array[i][0]).to_not be_nil
                end
                expect(encounters_array[16]).to be_nil
            end
            
            it "should create an array of arrays of monsters from the desert" do
                encounters_array.each do |encounter_array|
                    encounter_array.each do |monster|
                        expect(monster.cr).to_not be_nil
                        expect(monster.terrains).to include(desert)
                    end
                end
            end
            
            it "should generate easier monsters in the middle indicies" do
                expect(maker.overall_cr_for_monster_array(encounters_array[6]) <= (party_cr * 1.5)).to be_truthy
                expect(maker.overall_cr_for_monster_array(encounters_array[7]) <= (party_cr * 1)).to be_truthy 
                expect(maker.overall_cr_for_monster_array(encounters_array[8]) <= (party_cr * 1)).to be_truthy
                expect(maker.overall_cr_for_monster_array(encounters_array[9]) <= (party_cr * 1.5)).to be_truthy 
            end
            
            it "should generate significantly harder monsters at the first indices" do
                expect(maker.overall_cr_for_monster_array(encounters_array[0]) >= (party_cr * 2)).to be_truthy
                expect(maker.overall_cr_for_monster_array(encounters_array[1]) >= (party_cr * 1.5)).to be_truthy
            end
            
            it "should generate significantly harder monsters at the last indicies" do
                expect(maker.overall_cr_for_monster_array(encounters_array[14]) >= (party_cr * 2)).to be_truthy
                expect(maker.overall_cr_for_monster_array(encounters_array[15]) >= (party_cr * 1.5)).to be_truthy
            end
            
            it "should generate no encounters that will instakill the party" do
                encounters_array.each do |encounter_array|
                     expect(maker.overall_cr_for_monster_array(encounter_array) <= (party_cr * 3)).to be_truthy
                end
            end
            
            it "should generate no more than 5 of a given moster type" do
                encounters_array.each do |encounter_array|
                    counts = Hash.new(0)
                    encounter_array.each { |type| counts[type] += 1 }
                    counts.each do |key, count|
                        expect(count <= 7).to be_truthy
                    end
                end
            end
            
                
        end
        
        context "when party CR is 4 and underwater" do
            party_cr = 4.0
            underwater = Terrain.find_by_name('Underwater')
            maker = EncounterTableMaker.new([underwater], party_cr)
            encounters_array = maker.generate_array
            
            it "should create an array of arrays of monster from underwater" do
                encounters_array.each do |encounter_array|
                    encounter_array.each do |monster|
                        expect(monster.cr).to_not be_nil
                        expect(monster.terrains).to include(underwater)
                    end
                end
            end
        end
    end
    
    describe "creating pretty strings" do
        it "should coalesce similar monsters" do
            encounter_array = [Monster.find_by_name('Bandit'), Monster.find_by_name('Bandit'), Monster.find_by_name('Ice Mephit')]
            array_string = EncounterTableMaker.pretty_string_for_encounter(encounter_array)
            
            expect(array_string).to eq("2x Bandit, 1x Ice Mephit")
        end
    end
    
    describe 'calculating experience points' do
        it "should be able to calculate the experience point total of an encounter" do
            encounter_array = [Monster.find_by_name('Bandit'), Monster.find_by_name('Bandit'), Monster.find_by_name('Ice Mephit')]
            encounter_array2 = [Monster.find_by_name('Bandit'), Monster.find_by_name('Ice Mephit')]
            
            expect(EncounterTableMaker.xp_for_encounter(encounter_array)).to eq(150)
            expect(EncounterTableMaker.xp_for_encounter(encounter_array2)).to eq(125)
        end
    end
end
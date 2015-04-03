require "encounter_table_maker"
require "rails_helper"

def overall_cr_for_monster_array(monster_array)
    raw_cr_sum = 0.0
    monster_array.each do |monster|
         raw_cr_sum += monster.cr
    end
    group_size_factor = (monster_array.length) / 4
    overall_cr = raw_cr_sum * group_size_factor
    # puts "Overall CR is: #{overall_cr}\n for encounter: #{monster_array}"
    overall_cr
end

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
            
            it "should generate significantly harder monsters at the first indices" do
                expect(overall_cr_for_monster_array(encounters_array[0]) >= (party_cr * 2)).to be_truthy
                expect(overall_cr_for_monster_array(encounters_array[1]) >= (party_cr * 1.5)).to be_truthy
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
end
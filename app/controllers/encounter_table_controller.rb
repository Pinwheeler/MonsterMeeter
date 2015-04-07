require 'encounter_table_maker'

class EncounterTableController < ApplicationController
    respond_to :html, :js
    
    def index
        @encounter_table = EncounterTableMaker.new([],0.0)
        @party_cr = 0.0
        @encounter_terrain = []
    end
    
    def update
        @encounter_terrain = []
        Terrain.all.each do |terrain|
            puts "Searching for Terrain: #{terrain}"
            temp_terrain = params[terrain.name]
            if temp_terrain
                @encounter_terrain.push(terrain)
            end
        end
        @party_cr = params['party_cr']
        if @party_cr && @encounter_terrain.length > 0
            if @party_cr.to_f > 0
                @encounter_table = EncounterTableMaker.new(@encounter_terrain, @party_cr.to_f)
                @error = false
            else
                @error = "Party CR must be greater than 0"
            end
        else
            @error = "Please enter a Party CR and select at least one Terrain"
        end
        render 'index'
    end
    
    def print
        @encounter_print_list = []
        @cr_print_list = []
        @xp_print_list = []
        (0..15).each do |i|
            @encounter_print_list.push(params["encounter_#{i}"])
            @cr_print_list.push(params["cr_#{i}"])
            @xp_print_list.push(params["xp_#{i}"])
        end
    end
    
    def reroll
        reroll_num = params["reroll_num"].to_i
        party_cr = params["party_cr"].to_f
        terrains = []
        params["terrains"].each do |terrain_name|
            new_terrain = Terrain.find_by_name(terrain_name)
            terrains.push(new_terrain)
        end
        encounter_table = EncounterTableMaker.new(terrains, party_cr)
        encounter_array = encounter_table.encounter_array_for_slot(reroll_num)
        encounter_string = EncounterTableMaker.pretty_string_for_encounter(encounter_array)
        encounter_cr = encounter_table.overall_cr_for_monster_array(encounter_array)
        encounter_xp = EncounterTableMaker.xp_for_encounter(encounter_array)
        render :json => { 'string' => encounter_string, 'cr' => encounter_cr, 'xp' => encounter_xp}
    end
end

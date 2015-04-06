require 'encounter_table_maker'

class EncounterTableController < ApplicationController
    
    def index
        @encounter_table = EncounterTableMaker.new([],0.0)
        @party_cr = nil
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
        @encounter_table = EncounterTableMaker.new(@encounter_terrain, @party_cr.to_f)
        render 'index'
    end
end

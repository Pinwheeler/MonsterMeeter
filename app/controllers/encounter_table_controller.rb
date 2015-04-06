require 'encounter_table_maker'

class EncounterTableController < ApplicationController
    def index
        @encounter_table = EncounterTableMaker.new([],0.0)
    end
    
    def update
        puts params
        render 'index'
    end
end

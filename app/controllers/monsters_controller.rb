class MonstersController < ApplicationController
    
    def index
        @monsters = Monster.all
    end
    
    def show
        @monster = Monster.find(params[:id])
    end
    
    def new
        
    end
    
    def create
        @monster = Monster.new(monster_params)
        
        @monster.save
        redirect_to @monster
    end
    
    private
    def monster_params
        params.require(:monster).permit(:name,:cr)
    end
end

class TerrainsController < ApplicationController
    
    def index
        @terrains = Terrain.all
    end
    
    def show
        @terrain = Terrain.find(params[:id])
    end
    
    def new
        @terrain = Terrain.new
    end
    
    def edit
        @terrain = Terrain.find(params[:id])
    end
    
    def create
        @terrain = Terrain.new(terrain_params)
        
        if @terrain.save
            redirect_to @terrain
        else
            render 'new'
        end
    end
    
    def update
        @terrain = Terrain.find(params[:id])
        
        if @terrain.update(terrain_params)
            redirect_to @terrain
        else
            render 'edit'
        end
    end
    
    def destroy
        @terrain = Terrain.find(params[:id])
        @terrain.destroy
        
        redirect_to terrains_path
    end
    
    private
    def terrain_params
        params.require(:terrain).permit(:name)
    end
    
end

class Monster < ActiveRecord::Base
    
    has_and_belongs_to_many :terrains
    accepts_nested_attributes_for :terrains
    
    validates :name, presence: true
    validates :cr, presence: true
    
    def to_s
        "<Monster:: Name: #{name} CR: #{cr}>" 
    end
end

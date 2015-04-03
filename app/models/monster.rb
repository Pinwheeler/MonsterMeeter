class Monster < ActiveRecord::Base
    
    has_and_belongs_to_many :terrains
    accepts_nested_attributes_for :terrains
    
    validates :name, presence: true
end

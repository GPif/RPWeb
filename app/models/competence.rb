class Competence < ActiveRecord::Base
  has_many :character_competences
  has_many :characters, :through => :character_competences

  attr_accessible :base, :characteristic, :description, :name
end

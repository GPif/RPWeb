class CharacterTalent < ActiveRecord::Base
  belongs_to :talent
  belongs_to :character

  attr_accessible :character_id, :talent_id
end

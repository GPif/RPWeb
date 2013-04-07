class Character < ActiveRecord::Base
  belongs_to :user
  belongs_to :race
  attr_accessible :name, :race_id, :base_weapon_skill, :base_balistic_skill, :base_strength, 
	:base_toughness, :base_agility, :base_intelligence, :base_will_power, :base_fellowship,
        :base_attacks, :base_wounds, :base_mouvement, :base_insanity_points, :base_fate_points
end

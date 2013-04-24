class Character < ActiveRecord::Base
  belongs_to :user
  belongs_to :race

  has_many :character_competences
  has_many :competences, :through => :character_competences
  has_and_belongs_to_many :talents

  attr_accessible :name, :race_id, :base_weapon_skill, :base_balistic_skill, :base_strength, 
	:base_toughness, :base_agility, :base_intelligence, :base_will_power, :base_fellowship,
        :base_attacks, :base_wounds, :base_mouvement, :base_insanity_points, :base_fate_points

  def get_competence_bonus(competence)
    idx= self.character_competences.index { |o| o.competence_id == competence.id }
    bonus=self.character_competences[idx].bonus
    return bonus
  end

  def get_chara_comp(competence)
    if self.competences.include?(competence)
      idx= self.character_competences.index { |o| o.competence_id == competence.id }
      chara_comp=self.character_competences[idx]
      return chara_comp
    end
  end

  def add_competence(competence)
   if self.competences.include? competence
	idx= self.character_competences.index { |o| o.competence_id == competence.id }
	if self.character_competences[idx].bonus <= 10
		self.character_competences[idx].bonus += 10
	end
   else
      self.competences << competence
   end
  end
end

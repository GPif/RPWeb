class Character < ActiveRecord::Base
  belongs_to :user
  belongs_to :race
  belongs_to :career

  has_many :character_competences
  has_many :competences, :through => :character_competences
  has_and_belongs_to_many :talents

  before_create :profile_creation

  #Character
  attr_accessible :name, :race_id, :career_id
  #Details
  attr_accessible :age, :gender, :eye_color, :weight, :height, :star_sign, :number_of_sibling, :birthplace, :distinguishing_marks
  #Base Profile
  attr_accessible :base_weapon_skill, :base_balistic_skill, :base_strength, :base_toughness, 
  :base_agility, :base_intelligence, :base_will_power, :base_fellowship, 
  :base_attacks, :base_wounds, :base_mouvement, :base_insanity_points, :base_fate_points,
  :base_magic
  #Creation description
  attr_accessible :status 

  def base_strength_bonus
    if self.base_strength.nil?
      return 0
    else
      return self.base_strength / 10
    end
  end
  
  def base_toughness_bonus
    if self.base_toughness.nil?
      return 0
    else
      return self.base_toughness / 10
    end
  end
  
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

  private
  def profile_creation
    if (self.race_id == 0 or self.race_id >= 5)
      raise(InvalidRaceError, "This race is not handeled")
    end
    #t[race_id+][base profile id]
    t = [
          [ 30 , 20 , 20 , 30 , 10 , 20 , 20 , 10 , 1 , 3 , 0 , 0] ,
          [ 20 , 30 , 20 , 20 , 30 , 20 , 20 , 20 , 1 , 5 , 0 , 0] ,
          [ 10 , 30 , 10 , 10 , 30 , 20 , 20 , 30 , 1 , 4 , 0 , 0] ,
          [ 20 , 20 , 20 , 20 , 20 , 20 , 20 , 20 , 1 , 4 , 0 , 0] ,
        ]

    self.base_weapon_skill   = t[self.race_id-1][0] + Dice.throw + Dice.throw
    self.base_balistic_skill = t[self.race_id-1][1] + Dice.throw + Dice.throw
    self.base_strength       = t[self.race_id-1][2] + Dice.throw + Dice.throw
    self.base_toughness      = t[self.race_id-1][3] + Dice.throw + Dice.throw
    self.base_agility        = t[self.race_id-1][4] + Dice.throw + Dice.throw
    self.base_intelligence   = t[self.race_id-1][5] + Dice.throw + Dice.throw
    self.base_will_power     = t[self.race_id-1][6] + Dice.throw + Dice.throw
    self.base_fellowship     = t[self.race_id-1][7] + Dice.throw + Dice.throw
    self.base_attacks        = t[self.race_id-1][8]
    self.base_mouvement      = t[self.race_id-1][9]
    self.base_magic          = t[self.race_id-1][10]
    self.base_insanity_points= t[self.race_id-1][11]

    self.base_wounds         = starting_wound(Dice.throw)
    self.base_fate_points    = starting_fp(Dice.throw)
  end

  def starting_wound(dice10)
    #t[:race_id-1][:dice_part]
    t = [
          [ 11 , 12 , 13 , 14 ] ,
          [  9 , 10 , 11 , 12 ] ,
          [  8 ,  9 , 10 , 11 ] ,
          [ 10 , 11 , 12 , 13 ]
        ]
    if dice10 >= 1 and dice10 <= 3
      tmp = 0
    elsif dice10 >= 4 and dice10 <= 6
      tmp = 1
    elsif dice10 >= 7 and dice10 <= 9 
      tmp = 2
    elsif dice10 == 10
      tmp = 3
    else
      raise("Invalid dice result")
    end
    return t[self.race_id-1][tmp]
  end

  def starting_fp(dice10)
    #t[:race_id-1][:dice_part]
    t = [
          [ 1 , 2 , 3 ] ,
          [ 1 , 2 , 2 ] ,
          [ 2 , 2 , 3 ] ,
          [ 2 , 3 , 3 ]
        ]
    if dice10 >= 1 and dice10 <= 4
      tmp = 0
    elsif dice10 >= 5 and dice10 <= 7
      tmp = 1
    elsif dice10 >= 8 and dice10 <= 10
      tmp = 2
   else
      raise("Invalid dice result")
    end
    return t[self.race_id-1][tmp]
  end



end

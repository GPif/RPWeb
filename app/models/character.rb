#encoding: utf-8

class Character < ActiveRecord::Base
  belongs_to :user
  belongs_to :race
  belongs_to :career

  has_many :character_competences
  has_many :competences, :through => :character_competences

  has_many :character_talents
  has_many :talents, :through => :character_talents

  before_create :profile_creation , :initial_skill , :initial_talent
  before_save :buy_change

  #Character
  attr_accessible :name, :race_id, :career_id
  #Details
  attr_accessible :age, :gender, :eye_color, :weight, :height,
  :star_sign, :number_of_sibling, :birthplace, :distinguishing_marks
  #Base Profile
  attr_accessible :base_weapon_skill, :base_balistic_skill, :base_strength,
  :base_toughness, :base_agility, :base_intelligence, :base_will_power,
  :base_fellowship,  :base_attacks, :base_wounds, :base_mouvement,
  :base_insanity_points, :base_fate_points, :base_magic
  #Current profile
  attr_accessible :ws, :bs, :s, :t, :ag, :int, :wp, :fel,
  :a, :w, :mag, :m, :ip, :fp
  #Creation description
  attr_accessible :status
  #Experience
  attr_accessible :experience, :total_experience

  #Derivate profiles
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

  def sb
    if self.s.nil?
      return 0
    else
      return self.s / 10
    end
  end

  def tb
    if self.t.nil?
      return 0
    else
      return self.t / 10
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

  def shallya_mercy(profile)
    ref = {
      :ws => :base_weapon_skill   ,
      :bs => :base_balistic_skill ,
      :s  => :base_strength       ,
      :t  => :base_toughness      ,
      :ag => :base_agility        ,
      :int=> :base_intelligence   ,
      :wp => :base_will_power     ,
      :fel=> :base_fellowship
    }
    if ref.keys.include? profile
      self[ref[profile]]   = self.race.native_profile[profile] + 11
      self[profile]   = self.race.native_profile[profile] + 11
    else
      raise "Not a valid characteristic for Shallya's mercy"
    end
  end

private

  def buy_change
    self.changed_attributes.each do |k,v|
      main_prfl = [:ws,:bs,:s,:t,:ag,:int,:wp,:fel]
      if main_prfl.include? k.to_sym
        imp = self[k.to_sym] - v
        if imp % 5 != 0 or imp < 0
          return false
        end
      end
    end
  end

  def profile_creation

    self.base_weapon_skill   = self.race.native_profile[:ws] + Dice.throw10 + Dice.throw10
    self.base_balistic_skill = self.race.native_profile[:bs] + Dice.throw10 + Dice.throw10
    self.base_strength       = self.race.native_profile[:s]  + Dice.throw10 + Dice.throw10
    self.base_toughness      = self.race.native_profile[:t]  + Dice.throw10 + Dice.throw10
    self.base_agility        = self.race.native_profile[:ag] + Dice.throw10 + Dice.throw10
    self.base_intelligence   = self.race.native_profile[:int]+ Dice.throw10 + Dice.throw10
    self.base_will_power     = self.race.native_profile[:wp] + Dice.throw10 + Dice.throw10
    self.base_fellowship     = self.race.native_profile[:fel]+ Dice.throw10 + Dice.throw10
    self.base_attacks        = self.race.native_profile[:a]
    self.base_mouvement      = self.race.native_profile[:m]
    self.base_magic          = self.race.native_profile[:mag]
    self.base_insanity_points= self.race.native_profile[:ip]

    self.base_wounds         = self.race.starting_wound.from_dice(Dice.throw10)
    self.base_fate_points    = self.race.starting_fate_point.from_dice(Dice.throw10)

    self.ws  = self.base_weapon_skill
    self.bs  = self.base_balistic_skill
    self.s   = self.base_strength
    self.t   = self.base_toughness
    self.ag  = self.base_agility
    self.int = self.base_intelligence
    self.wp  = self.base_will_power
    self.fel = self.base_fellowship
    self.a   = self.base_attacks
    self.m   = self.base_mouvement
    self.mag = self.base_magic
    self.ip  = self.base_insanity_points
    self.w   = self.base_wounds
    self.fp  = self.base_fate_points
  end

  def initial_talent
    race = self.race
    race.native_talents_array.each do |t|
      if t.length == 1
        if t.first.random
          self.talents << random_talent(Dice.throw100)
        else
          self.talents << t.first.talent
        end
      end
    end
  end

  def initial_skill
    race = self.race
    race.native_skills_array.each do |c|
      if c.length == 1
        self.add_competence(c.first.competence)
      end
    end
  end

  #C'est moche !
  def random_talent(d100)
    rid = self.race.id
    part = {
      :halfling => [ 1..5 , 6..10 , 11..15 , 16..20 , 21..25 , 26..29 , 30..33 , 34..38 ,
          39..42 , 43..47 , -1..-1 , 48..51 , 52..53 , 54..57 , 58..62 , 63..67 , 68..72 ,
          73..77 , 78..82 , 83..87 , 88..91 , 92..95 , 96..100  ] ,
      :human    => [ 1..4 , 5..9  , 10..13 , 14..18 , 19..22 , 23..27 , 28..31 , 32..35 ,
          36..40 , 41..44 , 45..49 , 50..53 , 54..57 , 58..61 , 62..66 , 67..71 , 72..75 ,
          76..79 , 80..83 , 84..87 , 88..91 , 92..95 , 96..100  ]
    }
    t = [
      "Acuité auditive" ,
      "Acuité visuelle" ,
      "Ambidextre" ,
      "Calcul mental" ,
      "Chance" ,
      "Course à pied" ,
      "Sociable" ,
      "Dur à cuire" ,
      "Force accrue" ,
      "Guerrier né" ,
      "Imitation" ,
      "Intelligent" ,
      "Réflexes éclair" ,
      "Résistance à la magie" ,
      "Résistance accrue" ,
      "Résistance aux maladies" ,
      "Résistance aux poisons" ,
      "Robuste" ,
      "Sain d'esprit" ,
      "Sang froid" ,
      "Sixième sens" ,
      "Tireur d'élite" ,
      "Vision nocturne"
     ]
    if    self.race.id == 3
      r = :halfling
    elsif self.race.id == 4
      r = :human
    else
      raise "No random talent for this race"
    end
    id =  part[r].index{|x| x.include?(d100)}
    return Talent.find_by_name(t[id])
  end


end

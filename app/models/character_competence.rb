class CharacterCompetence < ActiveRecord::Base
  belongs_to :competence
  belongs_to :character

  attr_accessible :bonus, :character_id, :competence_id

  before_save :default_values
  def default_values
    self.bonus ||= 0
  end

end

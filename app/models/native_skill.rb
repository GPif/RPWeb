class NativeSkill < ActiveRecord::Base
  belongs_to :competence
  belongs_to :race

  attr_accessible :choice_ord, :competence_id, :requirement_id
end

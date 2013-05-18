class NativeTalent < ActiveRecord::Base
  belongs_to :talent
  belongs_to :race

  attr_accessible :choice_ord, :race_id, :requirement_id, :talent_id
end

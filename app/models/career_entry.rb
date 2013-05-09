class CareerEntry < ActiveRecord::Base
  attr_accessible :career_id, :next_career_id

  belongs_to :career
  belongs_to :next_career, :class_name => 'Career'

end

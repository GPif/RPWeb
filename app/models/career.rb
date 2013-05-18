class Career < ActiveRecord::Base

  #Descriptions
  attr_accessible :name, :description
  #Attributes
  attr_accessible :skills_desc, :talents_desc, :trappings_desc, :entry_desc, :exit_desc
  #Profile
  attr_accessible :ws, :bs, :s, :t, :ag, :int, :wp, :fel, :a, :w, :mag, :tb, :m, :ip, :fp 

  has_many :career_entry
  has_many :next_career, :through => :career_entry
end

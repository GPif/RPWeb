class Career < ActiveRecord::Base
  attr_accessible :a, :ag, :bs, :description, :fel, :mag, :name, :s, :t, :w, :wp, :ws, :skills_desc, :talents_desc, :trappings_desc, :entry_desc, :exit_desc, :int, :sb, :tb, :m, :ip, :fp

  has_many :career_entry
  has_many :next_career, :through => :career_entry
end

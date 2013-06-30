class NativeProfile < ActiveRecord::Base
  belongs_to :race

  attr_accessible :a, :ag, :ag, :bs, :fel, :int, :ip, :m, :mag, :race_id, :s, :t, :wp, :ws
end

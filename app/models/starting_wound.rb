class StartingWound < ActiveRecord::Base
   belongs_to :race
   attr_accessible :d10, :d1_3, :d4_6, :d7_9, :race_id

  def from_dice(d10)
    if    (d10 >=1 and d10<=3)
      return self.d1_3
    elsif (d10 >=4 and d10<=6)
      return self.d4_6
    elsif (d10 >=7 and d10<=9)
      return self.d7_9
     elsif (d10 ==10)
      return self.d10
    else
      raise "Unhandle dice result"
    end
  end

end

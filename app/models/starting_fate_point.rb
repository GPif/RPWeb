class StartingFatePoint < ActiveRecord::Base
  belongs_to :race

  attr_accessible :d1_4, :d5_7, :d8_10, :race_id

  def from_dice(d10)
    if    (d10 >=1 and d10<=4)
      return self.d1_4
    elsif (d10 >=5 and d10<=7)
      return self.d5_7
    elsif (d10 >=8 and d10<=10)
      return self.d8_10
    else
      raise "Unhandle dice result"
    end
  end
end

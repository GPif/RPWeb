class Dice
  def self.throw10
    tmp = ( rand(10) + 1 )
    Rails.logger.info "Dice 10 throwed : #{tmp}"
    return tmp
  end

  def self.throw100
    tmp = ( rand(10)*10 + rand(10) + 1 )
    Rails.logger.info "Dice 100 throwed : #{tmp}"
    return tmp
  end

end

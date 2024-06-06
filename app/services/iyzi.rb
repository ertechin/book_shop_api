class Iyzi
  attr_accessor :amount

  def initialize(amount)
    @amount = amount 
  end

  def process
    [true, "#{@amount} $ has been paid with Iyzi"]
  end
end
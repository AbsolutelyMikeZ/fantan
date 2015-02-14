class Pot
  attr_accessor :points, :winner
  
  def initialize(hand)
    @points = 0
    @winner = nil
    @hand_number = hand
  end
  
end
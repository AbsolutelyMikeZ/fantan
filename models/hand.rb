class Hand
  attr_accessor :dealer, :player_turn, :pot, :hand_number, :c, :d, :h, :s, :winner
  
  def initialize(number)
    @dealer = 0
    @player_turn = 0
    @pot = 0
    @hand_number = number
    @c = []
    @d = []
    @h = []
    @s = []
    @winner = 0
  end
end
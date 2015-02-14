class Player
  attr_accessor :name, :points, :hand
  
  def initialize(name)
    @name = name
    @points = 0
    @hand = []
  end
  
  def pay_pot
    @points -= 1
  end
  
  def clear_hand
    @hand = []
  end
  
  public
  def add_card_to_hand(card)
    @hand << card
  end
  
  def display_player
    "#{@name}: #{@points} points"
  end
  
  def display_hand
    @hand.sort_by! { |a| [a.suit, a.value] }
    @hand.each { |x| print x.display_card + " "}
  end
end
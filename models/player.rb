class Player
  attr_accessor :name, :points, :hand
  
  def initialize(name)
    @name = name
    @points = 0
    @hand = []
  end
  
  def clear_hand
    @hand = []
  end
  
  public
  def add_card_to_hand(card)
    @hand << card
  end
  
  
end
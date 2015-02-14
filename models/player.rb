class Player
  attr_accessor :name, :points, :hand
  
  def initialize(name)
    @name = name
    @points = 0
    @hand = []
  end
  
  def display_name_points
    "#{@name}: #{@points} points"
  end
  
  def display_hand #relies on card.rb - is this bad practice?
    @hand.sort_by! { |a| [a.suit, a.value] }
    @hand.each { |x| print display_card(x) + " "}
  end
end
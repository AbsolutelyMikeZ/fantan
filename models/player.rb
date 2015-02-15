class Player
  attr_accessor :name, :points, :hand, :human
  
  def initialize(name, human=true)
    @name = name
    @points = 0
    @hand = []
    @human = human
  end
  
  def display_name_points
    "#{@name}: #{@points} points"
  end
end
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
end
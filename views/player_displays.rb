def display_name_points(player)
    "#{player.name}: #{player.points} points"
end
  
def display_hand(player) #relies on card_displays.rb - is this bad practice?
    player.hand.sort_by! { |a| [a.suit, a.value] }
    player.hand.each { |x| print display_card(x) + " "}
end
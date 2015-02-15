def valid_plays(player, game)
  valid_cards = []
  player.hand.each{ |c|
    if game.is_valid_play(c)
      valid_cards << c
    end 
  }
  return valid_cards
end
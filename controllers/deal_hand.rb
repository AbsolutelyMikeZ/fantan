def deal_hand(players, deck)
  # clear old hand array for all players
  players.each { |x| x.hand = [] }
  
  # shuffle deck
  deck.shuffle!
  
  # loop through deck, loop through players, adding card to hand array
  i = 0
  deck.each{ |x| 
    players[i].hand <<  x
    if players.length - i == 1
      i = 0
    else
      i += 1
    end
  }
end
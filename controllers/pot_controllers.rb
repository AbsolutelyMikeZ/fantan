def pay_pot(pot, player, amount)
  player.points -= amount
  pot.points += amount
end
  
def win_pot(pot, player)
  player.points += pot.points
  pot.winner = player
end

class GamePlay
  attr_accessor :dealer, :all_players, :player_turn, :pot, :hand_number, :c, :d, :h, :s, :winner
  
  def initialize(players, number)
    @dealer = 0
    @all_players = players
    @pot = 0
    @hand_number = number
    @c = []
    @d = []
    @h = []
    @s = []
    @player_turn = @all_players[0]
  end
  
  def pay_pot(player, amount)
    player.points -= amount
    @pot += amount
  end
  
  def win_pot(player)
    player.points += @pot
    @winner = player
  end
  
  def next_player
    @all_players.rotate!
    @player_turn = @all_players[0]
  end

  def set_first_player(player_index)
    @all_players.rotate!(player_index)
    @player_turn = @all_players[0]
  end
end
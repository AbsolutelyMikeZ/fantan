class GamePlay
  attr_accessor :dealer, :all_players, :player_turn, :pot, :hand_number, :c, :d, :h, :s, :winner
  
  def initialize(players, number)
    @dealer = 0
    @all_players = players
    @pot = 0
    @hand_number = number
    @board = []
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

  def set_first_player
    # find player with 7 of Diamonds to go first - feel like this could be refactored
    has_7d = []
    @all_players.each{ |x|
      has_7d.push(x.hand.index { |y| y.suit == 'd' && y.number == 7 })  
    }
    player_index = has_7d.index { |x| !x.nil? }
    @all_players.rotate!(player_index)
    @player_turn = @all_players[0]
  end
  
  def play_card(card)
    if card.is_a? Array
      card = card[0]
    end
    
    @board << card
  end
  
  def is_valid_play(card)
  if card.is_a? Array
    card = card[0]
  end
  
  if @board.count { |x| x.suit == 'd'} == 0
    if card.suit == 'd' && card.number == 7
      return true
    else
      return false
    end
  end
  
  if card.number == 7
    return true
  else
    case card.suit
    when 'c'
      if @board.count { |x| x.suit == 'c'} == 0
        return false
      else
        if card.value - @board.select{ |x| x.suit == 'c'}.max_by(&:value).value == 1 || @board.select{ |x| x.suit == 'c'}.min_by(&:value).value - card.value == 1
          return true
        else
          return false
        end
      end
    when 'd'
      if card.value - @board.select{ |x| x.suit == 'd'}.max_by(&:value).value == 1 || @board.select{ |x| x.suit == 'd'}.min_by(&:value).value - card.value == 1
        return true
      else
        return false
      end
    when 'h'
      if @board.count { |x| x.suit == 'h'} == 0
        return false
      else
        if card.value - @board.select{ |x| x.suit == 'h'}.max_by(&:value).value == 1 || @board.select{ |x| x.suit == 'h'}.min_by(&:value).value - card.value == 1
          return true
        else
          return false
        end
      end
    when 's'
      if @board.count { |x| x.suit == 's'} == 0
        return false
      else
        if card.value - @board.select{ |x| x.suit == 's'}.max_by(&:value).value == 1 || @board.select{ |x| x.suit == 's'}.min_by(&:value).value - card.value == 1
          return true
        else
          return false
        end
      end
    else
        return false
    end
  end
end
  
  
  
end
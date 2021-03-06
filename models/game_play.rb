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
  
    if @board.empty?
      return card.suit == 'd' && card.number == 7
    else
      if card.number == 7
        return true
      else
        if @board.count { |x| x.suit == card.suit} == 0
          return false
        else
          return card.value - @board.select{ |x| x.suit == card.suit}.max_by(&:value).value == 1 || @board.select{ |x| x.suit == card.suit}.min_by(&:value).value - card.value == 1
        end
      end
    end
  end
  
  def show_board
    suits = { Clubs: "c", Diamonds: "d", Hearts: "h", Spades: "s" }
    suits.each_pair { |suit, abbr|
      print "#{suit}: "
      @board.select { |x| x.suit == abbr}
           .sort_by { |x| [x.value] }
           .each { |x| print "#{x.number} "}
      puts ""
    }
    
  end
end
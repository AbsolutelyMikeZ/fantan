Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f}
Dir["#{File.dirname(__FILE__)}/views/*.rb"].each { |f| require f}

# Create the cards and deck
alow = ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"]
ahigh = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]
suit = ["c", "d", "h", "s"]
deck = []
suit.each { |s|
  i = 1
  alow.each { |c|
    deck.push(Card.new(c, s, i))
    i += 1
    }
  }

# Create the players for the game
players = []
players.push(Player.new("Michael"))
players.push(Player.new("Regina(c)"))
players.push(Player.new("Albert(c)"))
players.push(Player.new("Mark(c)"))
players.push(Player.new("David(c)"))

# define method to deal the cards
def deal_hand(players, deck)
  players = players
  deck = deck
  
  # clear old hand array for all players
  players.each { |x| x.clear_hand }
  
  # shuffle deck
  deck.shuffle!
  
  # loop through deck, loop through players, adding card to hand array
  num_players = players.length
  i = 0
  deck.each{ |x| 
    players[i].add_card_to_hand(x)
    if num_players - i == 1
      i = 0
    else
      i += 1
    end
  }
end

def is_valid_play(card)
  if card.is_a? Array
    card = card[0]
  end
  
  if $diamonds.empty?
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
      if $clubs.empty?
        return false
      else
        if card.value - $clubs.max_by(&:value).value == 1 || $clubs.min_by(&:value).value - card.value == 1
          return true
        else
          return false
        end
      end
    when 'd'
      if card.value - $diamonds.max_by(&:value).value == 1 || $diamonds.min_by(&:value).value - card.value == 1
        return true
      else
        return false
      end
    when 'h'
      if $hearts.empty?
        return false
      else
        if card.value - $hearts.max_by(&:value).value == 1 || $hearts.min_by(&:value).value - card.value == 1
          return true
        else
          return false
        end
      end
    when 's'
      if $spades.empty?
        return false
      else
        if card.value - $spades.max_by(&:value).value == 1 || $spades.min_by(&:value).value - card.value == 1
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

def pay_or_play(player)
  puts "It is #{player.name}'s turn to play"
  player.display_hand
  puts ""
  puts "Type 'pay' or your card to play (i.e. '7d')"
  action = gets.chomp
  if action == 'pay'
    pay_the_pot(player)
    selected_card = ['paid']
    return selected_card
  else
    selected_card = []
    while selected_card.empty?
      selected_card = player.hand.select{ |x| x.number.to_s + x.suit.to_s == action.to_s}
      if selected_card.empty?
        puts "Card not in your hand - try selection again"
        action = gets.chomp
        if action == 'pay'
          selected_card = ['paid']
        end
      end
    end
    return selected_card
  end
end

def pay_the_pot(player)
  $pot += 1
  player.points -= 1
  puts "#{player.name} paid the pot!"
end

def play_card(card)
  if card.is_a? Array
    card = card[0]
  end
  
  case card.suit
  when 'd'
    $diamonds << card
  when 'c'
    $clubs << card
  when 'h'
    $hearts << card
  when 's'
    $spades << card
  else
    return false
  end
end


$hands_played = 0

loop do
  # initialize the hand by dealing and resetting the pot and board
  deal_hand(players, deck)
  $pot = 0
  $clubs = []
  $diamonds = []
  $hearts = []
  $spades = []

  # find player with 7 of Diamonds to go first
  has_7d = []
  players.each{ |x|
    has_7d.push(x.hand.index { |y| y.suit == 'd' && y.number == 7 })  
  }
  player_turn = has_7d.index { |x| !x.nil? }
  print players[player_turn].name
  puts " is first to go!"

  loop do
    loop do
      choice = pay_or_play(players[player_turn])
      if choice[0] == 'paid'
        turn_complete = true
      else
        if is_valid_play(choice)
          play_card(choice)
          players[player_turn].hand.delete(choice[0])
          turn_complete = true
        else
          puts "That card can't be played now, silly!"
        end
      end  
    
      break if turn_complete == true
    end
  
    break if players[player_turn].hand.empty?
    if player_turn == (players.length - 1)
      player_turn = 0
    else
      player_turn += 1
    end
  end
  puts "#{players[player_turn].name} won the pot of #{$pot} points"
  players[player_turn].points += $pot
  $hands_played += 1
  puts "Play another hand? ('Y' to play again)"
  play_again = gets.chomp
  break if play_again != 'Y'
end

puts "Final Results of #{$hands_played} hands played:"
players.each{ |x| puts "#{x.name}: #{x.points}"}

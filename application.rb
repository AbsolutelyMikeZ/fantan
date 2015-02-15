Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f}
Dir["#{File.dirname(__FILE__)}/views/*.rb"].each { |f| require f}
Dir["#{File.dirname(__FILE__)}/controllers/*.rb"].each { |f| require f}

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


def pay_or_play(current_game)
  puts "It is #{current_game.player_turn.name}'s turn to play"
  current_game.player_turn.display_hand
  puts ""
  print "Valid Plays: "
  valid_cards = valid_plays(current_game.player_turn, current_game)
  valid_cards.each{ |x| print x.display_card + " "}
  puts ""
  puts "Type 'pay' or your card to play (i.e. '7d')"
  action = gets.chomp
  if action == 'pay'
    current_game.pay_pot(current_game.player_turn, 1)
    puts "#{current_game.player_turn.name} paid the pot 1 point!"
    selected_card = ['paid']
    return selected_card
  else
    selected_card = []
    while selected_card.empty?
      selected_card = current_game.player_turn.hand.select{ |x| x.number.to_s + x.suit.to_s == action.to_s}
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

hand_number = 1

loop do
  # initialize the hand by dealing and creating a new pot and board
  deal_hand(players, deck)
  current_game = GamePlay.new(players, hand_number)

  # find player with 7 of Diamonds to go first
  current_game.set_first_player

  print current_game.player_turn.name
  puts " is first to go!"

  loop do
    loop do
      choice = pay_or_play(current_game)
      if choice[0] == 'paid'
        turn_complete = true
      else
        if current_game.is_valid_play(choice)
          current_game.play_card(choice)
          current_game.player_turn.hand.delete(choice[0])
          turn_complete = true
        else
          puts "That card can't be played now, silly!"
        end
      end  
    
      break if turn_complete == true
    end
  
    break if current_game.player_turn.hand.empty?
    current_game.next_player
  end
  puts "#{current_game.player_turn.name} won the pot of #{current_game.pot} points"
  win_pot(current_game.player_turn)
  hand_number += 1
  puts "Play another hand? ('Y' to play again)"
  play_again = gets.chomp
  break if play_again != 'Y'
end

puts "Final Results of #{hand_number - 1} hands played:"
players.each{ |x| puts x.display_name_points}

def display_cards(card_set)
  card_set.sort_by!{ |x| [x.suit, x.value] }
  card_set.each{ |x| print "#{x.number}#{x.suit} " }
  puts ""
end

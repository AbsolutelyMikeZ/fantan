# AI version 1 determines simply if the card is a stopper or not and if a stopper, assigns a score based on distance from 7

def bot_ai_v1(hand, valid)
  ai_ranking = []
  valid.each { |x|
    if x.value == 7
      if hand.count { |y| y.suit == x.suit } > 1
        score = 9 # temp
      else
        score = 36
      end
    elsif x.value > 7 && x.value < 13
      if hand.count { |y| y.suit == x.suit && y.value > x.value } > 0
        score = 10 # temp
      else
        score = 43 - x.value
      end
    elsif x.value < 7 && x.value > 1
      if hand.count { |y| y.suit == x.suit && y.value < x.value } > 0
        score = 10 # temp
      else
        score = 29 + x.value
      end
    else
      score = 30
    end
        
    ai_ranking.push(Ai_score.new(x, score))
  }
  
  ai_ranking.sort_by! { |x| [x.score] }
  puts "Score: #{ai_ranking[0].score}"
  return ai_ranking[0].card
end

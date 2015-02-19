# AI version 3 builds on version 2 by improving logic on playing 7's by holding back if max gap of 1 or less (meaning no gaps) or 3 or fewer cards total in the suit and max gap of 2

def bot_ai_v3(hand, valid)
  ai_ranking = []
  valid.each { |x|
    gaps = [] # reset gaps array for each card
    if x.value == 7
      if hand.count { |y| y.suit == x.suit } > 1
        temp_value = x.value
        hand.select { |z| z.suit == x.suit && z.value > x.value }
            .sort_by { |s| [s.value] }
            .each { |e| 
              gaps << e.value - temp_value
              temp_value = e.value
            }
        temp_value = x.value
        hand.select { |z| z.suit == x.suit && z.value < x.value }
            .sort_by { |s| [s.value] }
            .reverse
            .each { |e|
              gaps << temp_value - e.value
              temp_value = e.value
            }
        max_gap = gaps.sort.fetch(-1)
        if max_gap == 1
          if hand.count { |y| y.suit == x.suit && y.value < 7 } > 0 && hand.count { |y| y.suit == x.suit && y.value > 7 } > 0
            score = 20
          else
            score = 36
          end
        #elsif max_gap == 2 && hand.count { |y| y.suit == x.suit } < 4
         # score = 21
        else
          score = 16 - max_gap
        end
      else
        score = 37
      end
    elsif x.value > 7 && x.value < 13
      if hand.count { |y| y.suit == x.suit && y.value > x.value } > 0
        temp_value = x.value
        hand.select { |z| z.suit == x.suit && z.value > x.value }
            .sort_by { |s| [s.value] }
            .each { |e| 
              gaps << e.value - temp_value
              temp_value = e.value
            }
        max_gap = gaps.sort.fetch(-1)
        if max_gap == 1
          score = 20
        else
          score = 16 - max_gap
        end
      else
        score = 43 - x.value
      end
    elsif x.value < 7 && x.value > 1
      if hand.count { |y| y.suit == x.suit && y.value < x.value } > 0
        temp_value = x.value
        hand.select { |z| z.suit == x.suit && z.value < x.value }
            .sort_by { |s| [s.value] }
            .reverse
            .each { |e|
              gaps << temp_value - e.value
              temp_value = e.value
            }
        max_gap = gaps.sort.fetch(-1)
        if max_gap == 1
          score = 20
        else
          score = 16 - max_gap
        end
      else
        score = 29 + x.value
      end
    else
      score = 30
    end
    # puts "#{x.number}#{x.suit} Score: #{score}"    
    ai_ranking.push(Ai_score.new(x, score))
  }
  
  ai_ranking.sort_by! { |x| [x.score] }
  return ai_ranking[0].card
end
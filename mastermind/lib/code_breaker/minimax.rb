

module Minimax

  attr_reader :best_move

  def maximize(search_depth, remaining_moves)
    
    if search_depth == 0 or game_ends # game_ends = keine weiteren Kindknoten
      return evaluate()
    end 

    max_value = -Float::INFINITY
    all_moves = remaining_moves

    all_moves.each do |move|

     test_move(move)
     value = minimize(search_depth - 1)
     
     empty_chosen_move(move)

     if value > std_value
       max_value = value
     end
   end

   return max_value
 end


  def minimize(search_depth) #das steht für das zurückgegebene Feedback
    
    if search_depth == 0 or game_ends
      return evaluate()
    end 

    min_value = Float::INFINITY
    all_feedback = POSSIBLE_FEEDBACK.dup
    all_feedback.each do |feedback|

      test(move)
      value = maximize(search_depth - 1)

      empty_chosen_move(move)

      if value < min_value
        min_value = value
      end
    end

    return min_value
  end


  def test(move_or_feedback)
  end

  def game_ends?(sim_feedback)
    if sim_feedback == [4, 0]
  end


  def test_move(move)
  end

  def empty_chosen_move
  end

  def testif_best_move(depth, current_move)
    if depth == search_depth
      best_move = current_move
    end
  end

e^1
  private

  attr_accessor :best_move

  POSSIBLE_FEEDBACK = [
    [0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
    [1, 0], [1, 1], [1, 2], [1, 3],
    [2, 0], [2, 1], [2, 2],
    [3, 0], [3, 1],
    [4, 0]
  ]
end


module Evaluation

  @@possible_colors = (0..5).to_a # 6 Farben
  @@ALL_COMBINATIONS = included_colors.repeated_permutation(4).to_a #repeated_permutation(4) -> alle Kobinationen von 1-6 (Farbindex) mit 4 Stellen.
  KNUTHS_FIRST_GUESS = [0, 0, 1, 1]

  included_colors.repeated_permutation(4).to_a
  
  def evaluate()

    #muss eine einzige bewertende Zahl zurückgeben
  
    #wenn min gewinnt -> sehr niedrige Zahl
    #wenn max gewinnt -> sehr große Zahl
    #wenn unentschieden -> 0
  
    # bewerten auf Basis des last_guesses
  
  
    end
  


end




# Schleife, die beendet wird, wenn in included_colors 4 drin sind.
# 2 vars: 1. remaining_colors (std ist alle colors, werden nach und nach gelöscht) & 2. included colors (werden eingefügt) & excluded_colors

colors_to_check = []

included_colors = []
excluded_colors = []


# 1. Herausfinden, welche Farben enthalten sind (-> am Ende sind 256 übrig!)

def split_guess

  guess = [remaining_colors[0], remaining_colors[0], remaining_colors[1], remaining_colors[1]]
end 

def color_check(last_guess)

  color = last_guess[0]
  guess = [color, color, color, color]
end 

def sort_colors!(feedback)
  
  if feedback.sum > 0
    included_colors << last_guess[0] 
  else
    colors_to_check.delete(last_guess[0])
  end
end


left_colors = Array.new
right_colors = Array.new

first_lc = nil
second_lc = nil

first_rc = nil
second_rc = nil


def guessed?

  if first_lc && second_lc && first_rc && second_rc
end


def determined_colors

  if left_colors.length == 2 && right_colors.length == 2
end


until guessed?

  undetermined_side_colors = included_colors.dup


  def find_position
  end


  def guess_side

    undetermined_side_colors.each do |c| #muss nur 3 mal gemacht werden!!
       
    xc = excluded_colors[0]

    guess = [c, c, xc, xc] #xc = excluded color

    if feedback[1] >= 2
      left_colors << c1
      delete_color_if_guessed(c)

    elsif feedback[1] == 2
      first_lc == c1
      second_lc == c1

      left_colors << c1
      left_colors << c1

    else
      right_colors << c1
    end
    update_determined_color_side(c)
  end


  def update_determined_color_side(color)
    
    undetermined_side_colors.delete(color)
  end
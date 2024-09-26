
#TESTING!!!!

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

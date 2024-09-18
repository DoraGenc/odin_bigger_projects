

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
  
      testif_best_move(search_depth, move)
       max_value = value
     end
   end

   return max_value
 end


  def minimize(search_depth)
    
    if search_depth == 0 or game_ends
      return evaluate()
    end 

    min_value = Float::INFINITY
    all_moves = POSSIBLE_FEEDBACK.dup
    all_moves.each do |move|

      test_move(move)
      value = maximize(search_depth - 1)

      empty_chosen_move(move)

      if value < min_value
        testif_best_move(search_depth, move)
        min_value = value
      end
    end

    return min_value
  end


  def test_move(move)
  end

  def game_ends?
  end

  def generate_all_moves
  end

  def evaluate()

  #muss eine einzige bewertende Zahl zurückgeben

  #wenn min gewinnt -> sehr niedrige Zahl
  #wenn max gewinnt -> sehr große Zahl
  #wenn unentschieden -> 0



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

  POSSIBLE_FEEDBACK = []


end
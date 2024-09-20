

class TryVariations

  attr_reader :guess, :next_guess

  def initialize

    @guess = nil
    @next_guess = nil

  end

  def guess(left_colors, right_colors)

    if left_colors[0] == left_colors[1]

      guess = [left_colors[0], left_colors[0], right_colors[0], right_colors[1]]
      next_guess = [left_colors[0], left_colors[0], right_colors[1], right_colors[0]]
    
    elsif right_colors[0] == right_colors[1]
      
      guess = [left_colors[0], left_colors[1], right_colors[0], right_colors[0]]
      next_guess = [left_colors[1], left_colors[0], right_colors[0], right_colors[0]]

    else 

      guess = [left_colors[0], left_colors[1], right_colors[0], right_colors[1]]
      next_guess = [left_colors[1], left_colors[0], right_colors[1], right_colors[0]]

    end 
  end 

  private

  attr_accessor :guess, :next_guess
end
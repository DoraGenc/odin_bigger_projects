class FindPositionFeedback
  attr_accessor :left_color, :right_color

  def initialize
    @left_color = nil
    @right_color = nil
  end

  def evaluate(feedback, last_guess)
    if feedback[1] > 0

      left_color = last_guess[0]

    else

      right_color = last_guess[0]
    end
  end
end

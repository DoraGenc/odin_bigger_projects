class ColorCheckFeedback
  attr_reader :excluded_colors, :included_colors, :quantity

  def initialize(feedback, last_guess, last_feedback, color_check_guess) # hier ist was falsch, weil durch return_guess last_guess auch = color_check_guess ist
    @feedback = feedback
    @last_feedback = last_feedback
    @last_guess = last_guess
    @color_check_guess = color_check_guess

    @excluded_colors = []
    @included_colors = []

    @quantity = {}
  end

  def evaluate # (es gibt nur hits)
    if feedback[1] == 0 # hits

      # = die Farbe aus color_check ist nicht enthalten, aber die 2. des split_guess!

      excluded_colors << last_guess[0] # ist excluded
      included_colors << last_guess[2] # ist included

    else

      quantity[color_check_guess[0]] = feedback[1] # so oft kommt die Farbe vor

      if feedback[1] < last_feedback.sum # wenn hits, aber weniger als beim split_guess

        included_colors << last_guess[0] # ist included
        included_colors << last_guess[2] # ist included
      end
    end
  end

  private

  attr_reader :feedback, :last_feedback, :last_guess, :color_check_guess
  attr_accessor :excluded_colors, :included_colors, :quantity
end



class SplitGuessFeedback

  attr_reader :change_strat, :excluded_colors, :split_guess

  def initialize(feedback, last_guess) #last_guess nicht bekommen?s

    @feedback = feedback
    @last_guess = last_guess

    @change_strat = nil
    @split_guess = nil
    @excluded_colors = nil

  end

  def evaluate

    if feedback[0] == 4
      return guess = split_win #Die Logik funktioniert leider nicht so
    end

    if feedback.sum > 0 #= mindestens eine Farbe enthalten!!

     change_strat = true # -> color_check_strat

    else #beide Farben sind nicht enthalten

      excluded_colors << last_guess
    end
  end



  def split_win

    guess = [last_guess[2], last_guess[2], last_guess[0], last_guess[0]]
  end


  private

  attr_reader :feedback, :last_guess
  attr_accessor :guess, :change_strat
end
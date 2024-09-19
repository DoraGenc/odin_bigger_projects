require 'computer_guesser.rb'
require_relative 'color.rb'

class CodeBreaker

 def initialize

  @colors = (0..5).to_a

  @feedback = nil
  @last_feedback = nil

  @strat_state = nil

  # strat_states (strategies)
  @split_guess_strat = true
  @split_guess_feedback = false

  @color_check_strat = false
  @color_check_feedback = false

  @find_side_strat = false
  @find_side_feedback = false

  @find_position_strat = false
  @find_position_feedback = false

  @try_variations_strat = false
  @try_variations_feedack = false

  @last_guess = nil
  @last_feedback = nil
  @color_check_guess = nil

  @colors_to_check = colors.dup
  @checked_colors = [] #checked Farben, deren state aber unklar sind

  @included_colors = []
  @excluded_colors = [] 

  @undetermined_side_colors = []

  @left_colors = []
  @right_colors = []

  # falls der nächste guess zum win führt:

  @next_guess = nil
  @win_next_round = false
 end 


  def first_guess

    first_guess = [colors_to_check[0], colors_to_check[0], colors_to_check[1], colors_to_check[1].]

    change_color_state(colors_to_check[0])
    change_color_state(colors_to_check[0])

    return first_guess
  end

  



  # Methoden zum Updaten

  def change_color_state(color)

    color_to_check.delete(color)
    checked_colors << color
  end

  def receive_new_feedback(new_feedback)

    feedback = new_feedback #1. feedback zuweisen
    guess                   #2. guessen
    update_last_feedback    #3. feedback zu last_feedback machen & feedback leeren
  end

  def update_last_feedback

    last_feedback = feedback
    feedback = nil
  end

  def update_excluded_colors!(colors) #nimmt nur index zahlen an 

    if colors.to_s.length = 1
      
      excluded_colors << colors.to_i

    elsif colors.to_s.length > 1

      excluded_color << colors
      excluded_color = excluded_color.flatten!.uniq!
    end
  end

  def update_included_colors!(colors)

      included_color << colors
      included_color = excluded_color.flatten!
    end
  end

  def update_quantity!(hash)
    # Das Hash ist: color_index => quantity
  
    colors.each do |color|
      if hash.key?(color)
        quantity = hash[color]
  
        quantity.times do
          update_included_colors!(color)
        end
      end
    end
  end


  def color_check

    color_check_strat = true
    split_guess_strat = false

    last_guess.flatten.uniq

    color_check = ColorCheck.new(last_guess)
    guess = color_check.guess

    color_check_guess = guess
    change_color_state(guess)

    return guess
  end



  def guess

    #until guess ist festgelegt?

    case
    when strat_state == nil
        
      change_strat(split_guess_feedback)
      return guess = first_guess


    when strat_state == split_guess_strat

      split_guess = SplitGuess.new
      change_strat(split_feedback_strat)

     return guess = split_guess.guess(colors_to_check)


    when strat_state == split_guess_feedback

      split_feedback = SplitGuessFeedback.new(feedback)
      
      if split_feedback.guess

        win_next_round = true
        return next_guess = split_feedback.guess


      elsif split_feedback.change_strat

        change_strat(color_check_guess)

      elsif split_feedback.excluded_colors

        update_excluded_colors!(split_feedback.excluded_colors)
      end
    

    when strat_state == color_check_strat

      color_check = ColorCheck.new
      change_strat(color_check_feedback)

      return guess = color_check.guess(last_guess)


    when strat_state == color_check_feedback

      color_check_feedback = ColorCheckFeedback.new(feedback, last_guess, last_feedback, color_check_guess)
      color_check_feedback.evaluate

      update_included_colors!(color_check.included_colors)
      update_excluded_colors!(color_check.excluded_colors)
      update_quantity!(color_check.quantity)

      if colors_to_check.length == 0

        change_strat(find_position_strat)

      else 
        change_strat(split_guess_strat)
      end
    

    when strat_state == find_position_strat

      find_position_guess = FindPosition.new

      undetermined_side_colors.delete_at(0)
      change_strat(find_position_feedback)

      return guess = find_position_guess.guess(undetermined_side_colors, excluded_colors)

  
    when strat_state == find_position_feedback

      find_position_feedback = FindPositionFeedback.new
      find_position_feedback.evaluate(feedback, last_guess)

      if find_position_feedback.left_color

        undetermined_side_colors.delete_at(find_position_feedback.left_color)
        left_colors << find_position_feedback.left_color

      else
        undetermined_side_colors.delete_at(find_position_feedback.right_color)
        right_colors << find_position_feedback.right_color
      end

      change_strat(find_position_guess)

      if undetermined_side_colors.length == 1

       determine_remaining_side
       change_strat(try_variations_strat)
      end 


    when try_variations_strat #wenn wir nur noch left & right colors haben :3

      try_variations_guess = TryVariations.new

      change_strat(try_variations_feedack)
      win_next_round = true

      next_guess = try_variations_guess.next_guess
      return guess = try_variations_guess.guess

    
    when try_variations_feedback

      return guess = next_guess
    end 
  end 


  def determine_remaining_side

    if left_colors.length == 2
      left_colors << undetermined_side_colors.first #first, da es undetermined_side_colors ein Array ist

    elsif right_colors.length < 2
      right_colors << undetermined_side_color.first
    end
  end
  
  def change_strat(strat)

    strat_state = strat
    strat = false
  end 


  private

  attr_accessor :feedback, :split_guess_strat
end
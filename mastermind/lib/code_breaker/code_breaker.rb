require 'odin_bigger_projects/mastermind/lib/computer_guesser.rb'
require_relative 'color.rb'
require_relative 'color_check_feedback.rb'
require_relative 'color_check.rb'
require_relative 'find_position_feedback.rb'
require_relative 'find_position.rb'
require_relative 'side_guess.rb'
require_relative 'side_guess_feedback.rb'
require_relative 'split_guess.rb'
require_relative 'split_guess_feedback.rb'
require_relative 'try_variations.rb'

require 'odin_bigger_projects/mastermind/lib/feedback.rb'


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

    first_guess = [colors_to_check[0], colors_to_check[0], colors_to_check[1], colors_to_check[1]]

    change_color_state(colors_to_check[0])
    change_color_state(colors_to_check[0])

    return first_guess
  end

  def change_color_state(color)

    colors_to_check.delete(color)
    checked_colors << color
  end

  def update_last_feedback

    last_feedback = feedback
    feedback = nil
  end

  def update_last_guess

    last_guess = guess
    guess = nil
  end


  def update_excluded_colors!(colors) #nimmt nur index zahlen an 

    if colors.to_s.length == 1
      
      excluded_colors << colors.to_i

    elsif colors.to_s.length > 1

      excluded_colors << colors
      excluded_colors = excluded_color.flatten!.uniq!
    end
  end

  def update_included_colors!(colors)

      included_colors << colors
      included_colors = excluded_color.flatten!
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


  def guess

    created_guess = false

    if win_next_round
      
      created_guess = true
      return next_guess
    end

    until created_guess

    case strat_state
    when nil
        
      guess = first_guess
      change_strat(split_guess_feedback)
      
      created_guess = true
      

    when split_guess_strat

      split_guess = SplitGuess.new
     guess = split_guess.guess(colors_to_check)
     change_strat(split_feedback_strat)
     created_guess = true

    when split_guess_feedback

      split_feedback = SplitGuessFeedback.new(feedback)
      
      if split_feedback.guess

        win_next_round = true
        next_guess = split_feedback.guess
       
        created_guess = true

      elsif split_feedback.change_strat
        change_strat(color_check_guess)

      elsif split_feedback.excluded_colors
        update_excluded_colors!(split_feedback.excluded_colors)
      end
    

    when color_check_strat

      color_check = ColorCheck.new
      guess = color_check.guess(last_guess)
      change_strat(color_check_feedback)

      created_guess = true


    when color_check_feedback

      color_check_feedback = ColorCheckFeedback.new(feedback, last_guess, last_feedback, color_check_guess)
      color_check_feedback.evaluate

      update_included_colors!(color_check.included_colors)
      update_excluded_colors!(color_check.excluded_colors)
      update_quantity!(color_check.quantity)

      if colors_to_check.empty?
        change_strat(find_position_strat)

      else 
        change_strat(split_guess_strat)
      end
    

    when find_position_strat

      find_position_guess = FindPosition.new

      undetermined_side_colors.delete_at(0)
      guess = find_position_guess.guess(undetermined_side_colors, excluded_colors)
      change_strat(find_position_feedback)

      created_guess = true

  
    when find_position_feedback

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
      next_guess = try_variations_guess.next_guess
      guess = try_variations_guess.guess

      win_next_round = true
      created_guess = true

    else
    puts "No case found????"

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

  def receive_new_feedback(new_feedback)

    feedback = new_feedback
    new_guess = return_guess
  end

  def return_guess

  new_guess = guess

  update_last_feedback
  update_last_guess

  return new_guess
  end 




  private

  attr_accessor :feedback, :split_guess_strat, :excluded_colors, :included_colors, :last_feedback, :last_guess, 
              :split_guess_feedback, :color_check_strat, :color_check_feedback, :find_side_strat, :find_side_feedback, 
              :find_position_strat, :find_position_feedback, :try_variations_strat, :colors_to_check, :checked_colors, 
              :undetermined_side_colors, :left_colors, :right_colors, :next_guess, :win_next_round

  attr_reader :colors
end
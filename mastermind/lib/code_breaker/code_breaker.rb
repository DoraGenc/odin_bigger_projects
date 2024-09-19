require 'computer_guesser.rb'
require_relative 'color.rb'

class CodeBreaker

 def initialize

  @colors = (0..5).map { |i| Color.new(i) } #5 Color-Instanzen mit dem Index jeweils 1-5

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
 end 


  def first_guess

    first_guess = [colors_to_check[0].color_index, colors_to_check[0].color_index, colors_to_check[1].color_index, colors_to_check[1].color_index]

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

    if colors.to_s.length = 1
      
      included_colors << colors.to_i

    elsif colors.to_s.length > 1

      included_color << colors
      included_color = excluded_color.flatten!.uniq!
    end
  end

  def update_quantity!(hash)

    #das hash ist: color => quantity
    colors.each do |color_instance|

      if hash.key?(color_instance.color_index)

        color_instance.quantity = hash[color_instance.color_index]
        break
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

      guess = split_guess.guess(colors_to_check)


    when strat_state == split_guess_feedback

      split_feedback = SplitGuessFeedback.new(feedback)
      
      if split_feedback.guess
        return next_guess = split_feedback.guess

      elsif split_feedback.change_strat

        change_strat(color_check_guess)

      elsif split_feedback.excluded_colors

        update_excluded_colors!(split_feedback.excluded_colors)
      end
    

    when strat_state == color_check_strat

      color_check = ColorCheck.new
      change_strat(color_check_feedback)

      guess = color_check.guess(last_guess)


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

      guess = find_position_guess.guess(undetermined_side_colors, excluded_colors)

  
    when strat_state == find_position_feedback

      find_position_feedback = FindPositionFeedback.new
      

      if undetermined_side_colors.length == 1

        d


    when try_variations_strat



    when try_variations_feedback

  end 




  def determine_side

    if left_colors.length == 2
      left_colors << undetermined_side_colors

    elsif right_colors.length < 2
      right_colors << undetermined_side_colors
    end
  end









  #GUESS VERLAGERN AUF CHECK_GUESS_STATE

  def guess  #muss feedback etc. zugreifen können 

    if guess_state == split_guess_feedback

      split_guess_feedback = SplitGuessFeedback.new(feedback, last_guess)
      split_guess_feedback.evaluate 
      
     
    elsif guess_state == color_check_feedback

      color_check_feedback = ColorCheckFeedback.new(feedback, last_guess, last_feedback, color_check_guess)
      color_check_feedback.evaluate

      update_included_colors!(color_check.included_colors)
      update_excluded_colors!(color_check.excluded_colors)
      update_quantity!(color_check.quantity)
  end


  def find_strat_state!

    case
    when split_guess_strat
      strat_state = split_guess_strat

    when split_guess_feedback
      strat_state = split_guess_feedback


    when color_check_strat
      strat_state = color_check_strat
    
    when color_check_feedback
      strat_state = color_check_feedback


    when find_side_strat
      strat_state = find_side_strat
    
    when find_side_feedback
      strat_state = find_side_feedback


    when find_position_strat
      strat_state = find_position_strat

    when find_position_feedback
      strat_state = find_position_feedback


    when try_variations_strat
      strat_state = try_variations_strat

    when try_variations_feedback
      strat_state = try_variations_feedback

    else
      strat_state = nil # falls erster guess
    end
  end


  def change_strat(strat)

    strat_state = strat
    strat = false
  end 




















  private

  attr_accessor :feedback, :split_guess_strat
end








  #1 Filter colors

  def guess(feedback)

    when color_check_guesses.length != 0
      
      guessed_code = color_check_guessess[0] #alle 3 possible split_guesses durchgehen
      remove_guessed_colors! #wenn eine combo geguessed, dann entfernen
    end
    guessed_code
  end 

  def remove_guessed_colors!
    color_check_guesses.shift #=delete
  end













  def has_duplicates?(combination)
    combination.uniq.size < combination.size #wenn das .uniq Array kleiner ist als das Original, gibt es Farben doppelt
  end

  def filter_combinations!

    filtered_combinations = remaining_combinations.reject! do |combination|
        
      # 1: Alle Kombinationen mit excluded_colors ausschließen
      excluded_color.each do |excluded_color|
      
        if combination.any?(excluded_color)
          remaining_combinations.delete(combination)
        end 
      end 

      unless has_duplicates?(combination)

        #2: Alle Kombinationen mit confirmed_left_colors rechts ausschließen
        if  ![combination[0], combination[1]].any?(confirmed_left_colors) # Falls die ersten beiden Stellen keine Zahl aus left_colors sind
          remaining_combinations.delete(combination)
        end 

        #2.1: Alle Kombinationen mit confirmed_rigth_colors links ausschließen
        if  ![combination[2], combination[3]].any?(confirmed_right_colors)
          remaining_combinations.delete(combination)
        end
      end
    end 
  end 





  






  end

  private

  attr_accessor :possible_colors, :confirmed_colors, :excluded_color, :confirmed_left_colors, :confirmed_right_colors, :last_guess, :last_feedback, :split_guesses
end
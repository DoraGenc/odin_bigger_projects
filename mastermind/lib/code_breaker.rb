require 'computer_guesser.rb'

class CodeBreaker < ComputerGuesser

  POSSIBLE_COLORS = (0..5).to_a # 6 Farben
  ALL_COMBINATIONS = included_colors.repeated_permutation(4).to_a
  SPLIT_GUESSES = [[0, 0, 1, 1], [2, 2, 3, 3], [4, 4, 5, 5]]

  def initialize

    @possible_combinations = ALL_COMBINATIONS.dup
    @possible_colors = POSSIBLE_COLORS.dup
    @split_guesses = SPLIT_GUESSES.dup

    @last_guess = nil
    @last_feedback = nil
    
    @confirmed_colors = []
    @excluded_colors = []
    @confirmed_left_colors = []
    @confirmed_right_colors = []
  end 

  #1 Filter colors

  def guess(turn_counter, feedback)

    if turn_counter = 1
      return guess = SPLIT_GUESSES[0]
    end

  when split_guesses.length != 0
     
      guessed_code = split_guesses[0] #alle 3 possible split_guesses durchgehen
      remove_guessed_split_guesses! #wenn eine combo geguessed, dann entfernen
    end
    guessed_code
  end

  def remove_guessed_split_guesses!
    split_guesses.delete_at(0)
  end

  def react_to_split_feedback(last_feedback)

    #falls blows oder hits
    if last_feedback[0] > 0 || last_feedback[1] > 0
      color_check_guess(last_guess[0])

    elsif last_feedback[0] = 0 && last_feedback[1] = 0
    




  end



  def color_check_guess(color_index)

    color = POSSIBLE_COLORS[color_index]
    [color, color, color, color]
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
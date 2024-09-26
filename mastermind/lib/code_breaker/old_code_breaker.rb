require_relative 'color_check_feedback.rb'
require_relative 'color_check.rb'
require_relative 'find_position_feedback.rb'
require_relative 'find_position.rb'
require_relative 'split_guess.rb'
require_relative 'split_guess_feedback.rb'
require_relative 'try_variations.rb'


class CodeBreaker

  def initialize

    @colors = (0..5).to_a

    @feedback = nil
    @last_feedback = nil

    @is_first_guess = true

    # strat_states (strategies)
    @split_guess_strat = false
    @split_guess_feedback = false

    @color_check_strat = false
    @color_check_feedback = false

    @find_side_strat = false
    @find_side_feedback = false

    @find_position_strat = false
    @find_position_feedback = false

    @try_variations_strat = false

    @current_guess = nil
    @last_guess = nil
    @last_feedback = nil
    @color_check_guess = nil

    @colors_to_check = @colors.dup
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

  def receive_new_feedback(new_feedback)

    feedback = new_feedback #1. feedback aktualisieren
  end

  def return_guess

    puts "Return guess method called."

   new_guess = guess # 1. guess aufrufen
   current_guess = new_guess

   update_last_feedback!
   update_last_guess!

   return new_guess # 2. guess returnen
 end

  def create_first_guess

    puts "FIRST GUESS, COLORS TO CHECK ARE: #{@colors_to_check}"

    the_guess = [colors_to_check[0], colors_to_check[0], colors_to_check[1], colors_to_check[1]]
    change_color_state!([colors_to_check[0], colors_to_check[1]])

    return the_guess
  end

  def change_color_state!(colors)

    colors.each do |color|
      colors_to_check.delete(color)
      checked_colors << color
    end
  end

  def update_last_feedback!

    last_feedback = feedback
    feedback = nil
  end

  def update_last_guess!

    last_guess = current_guess
    current_guess = nil
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

     puts "Guess method called."
     puts caller.join("\n")  # Zeigt den Aufruf-Stack an

    created_guess = false

    if win_next_round
      
      created_guess = true
      return next_guess
    end

    
    if is_first_guess
  
      is_first_guess = false
      print "is first guess #{@is_first_guess}" #die instanzvariable wird nicht geändert
      print "is first guess #{is_first_guess}"
      guess = create_first_guess

      puts "in is first guess: split guess will hopefully be true (l. 161)"
      split_guess_feedback = true
      puts "split guess state: #{@split_guess_feedback}"

      feedback = 0
      return guess

    elsif split_guess_strat

      puts "Split guess strat called!"

      split_guess_strat = false

      split_guess = SplitGuess.new
      guess = split_guess.guess(colors_to_check)
      split_guess_feedback = true

      update_last_guess!(guess)
      return guess

    elsif split_guess_feedback

      puts "Split guess feedback called!"

        puts "in split guess, split guess state: #{split_guess_feedback}"
      split_guess_feedback = false
        puts "split guess state: #{split_guess_feedback}"

      split_feedback = SplitGuessFeedback.new(feedback, last_guess)
      split_feedback.evaluate
      
      if split_feedback.split_guess #Logik funktioniert nicht so

        win_next_round = true
        next_guess = split_feedback.guess

      elsif split_feedback.excluded_colors
        update_excluded_colors!(split_feedback.excluded_colors)

        #elsif split_guess_feedback.change_strat
      else
        self.color_check_strat = true

      end

      change_color_state!(last_guess)

    
    elsif color_check_strat

      color_check_strat = false
      
      color_check = ColorCheck.new
      guess = color_check.guess(last_guess)
      color_check_feedback = true

      return guess


    elsif color_check_feedback

      color_check_feedback = false


      color_check_feedback = ColorCheckFeedback.new(feedback, last_guess, last_feedback, color_check_guess)
      color_check_feedback.evaluate

      update_included_colors!(color_check.included_colors)
      update_excluded_colors!(color_check.excluded_colors)
      update_quantity!(color_check.quantity)

      if colors_to_check.empty?
        find_position_strat = true 

      else 
        split_guess_strat = true
      end
    
      change_color_state!(last_guess)
      
    elsif find_position_strat

      puts "find-positions called"

      find_position_strat = false
 

      find_position_guess = FindPosition.new

      undetermined_side_colors.delete_at(0)
      guess = find_position_guess.guess(undetermined_side_colors, excluded_colors)
      find_position_feedback = true

      puts "COLOR CHECK SET FIND POSITION TO TRUE!!"

      return guess

  
    elsif find_position_feedback #undetermined_side_colors werden bestimmt

      find_position_feedback = false

      find_position_feedback = FindPositionFeedback.new
      find_position_feedback.evaluate(feedback, last_guess)

      if find_position_feedback.left_color
        undetermined_side_colors.delete_at(find_position_feedback.left_color)
        left_colors << find_position_feedback.left_color

      else
        undetermined_side_colors.delete_at(find_position_feedback.right_color)
        right_colors << find_position_feedback.right_color
      end


      if undetermined_side_colors.length == 1 || undetermined_side_colors.empty?  #wenn nur noch eine übrig ist oder keine
        determine_remaining_side
        try_variations_strat = true

      else
        find_position_guess = true
      end 


    elsif try_variations_strat #wenn wir nur noch left & right colors haben :3

      
      try_variations_strat = false

      try_variations_guess = TryVariations.new
      next_guess = try_variations_guess.next_guess #quantity mit einbeziehen!!! 
      guess = try_variations_guess.guess

      win_next_round = true

      return guess

    else
      puts "No case found????"

    end
  
    return guess
  end


  def determine_remaining_side

    if left_colors.length == 2
      left_colors << undetermined_side_colors.first #first, da es undetermined_side_colors ein Array ist

    elsif right_colors.length < 2
      right_colors << undetermined_side_color.first
    end
  end


  private

  attr_accessor :feedback, :split_guess_strat, :excluded_colors, :included_colors, :last_feedback, :last_guess,
              :split_guess_feedback, :color_check_strat, :color_check_feedback, :find_side_strat, :find_side_feedback, 
              :find_position_strat, :find_position_feedback, :try_variations_strat, :colors_to_check, :checked_colors, 
              :undetermined_side_colors, :left_colors, :right_colors, :next_guess, :win_next_round, :strat_state, :current_guess, :is_first_guess

  attr_reader :colors
end
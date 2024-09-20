#guess_counter annehmen aus game
#feedback annehmen

class CodeBreaker

  split_guess_strat = true
  split_guess_feedback = false

  color_check_strat = false
  color_check_feedback = false

  last_guess = nil
  last_feedback = nil

  next_guess = nil


  colors_to_check = [] #ungecheckte Farben

  checked_colors = [] #checked Farben, deren state aber unklar sind

  included_colors = []
  excluded_colors = [] 

  left_colors = []
  right_colors = []

  first_lc = []
  second_lc = []

  first_rc = []
  second_rc = []




  def first_strat

    if guess_counter == 0

      return guess = first_guess
    end

    if split_guess_strat && !split_guess_feedback 

      return guess = split_guess
    

    elsif split_guess_strat && split_guess_feedback

      if feedback.sum > 0
        return color_check_strat = true
        
      else
        next_guess = colorcheck???
        

      end


  end
    

  def first_guess

    first_guess = [colors_to_check[0], colors_to_check[0], colors_to_check[1], colors_to_check[1]]

    change_color_state(colors_to_check[0])
    change_color_state(colors_to_check[0])
  end


  def save_last_guess(guess)
    
    last_guess = guess
  end

  def save_last_feedback(feedback)

    last_feedback = feedback
  end

  def change_color_state(color_index)

  colors_to_check.delete(color_index)
  checked_colors << color_index
  end




  # 1: Split guess

  def split_guess
    


  end


  # 2: ColorCheck guess

  def color_check_guess
  
    

  end






  end
require_relative 'speech.rb'
require_relative 'setter.rb'
require_relative 'players.rb'

class Feedback

  attr_reader :current_blows_and_hits

  def initialize
    @current_blows_and_hits = [0, 0]
  end


  def count_blows_and_hits(guessed_code, secret_code)
   
    blows = 0
    hits = 0
    
    guessed_code.each_with_index do |guess, index|
        
      next if !secret_code.include?(guess)

      if secret_code[index] == guess

        hits += 1

      else
        blows += 1
      end
    end 

    self.current_blows_and_hits = [blows, hits]
  end 


  def check_if_win?(players, guess_counter)

    if self.current_blows_and_hits[1] == 4 
      players.guesser.win = true
      return true
      
    elsif guess_counter >= 12
      players.setter.win = true
      return true

    else
      puts "The Game continues!".bold.black
      return false
      #guesser.random_voiceline #muss nochmal geprüft werden, ob sowas funktioniert
    end
  end


  private

  attr_writer :current_blows_and_hits

end 
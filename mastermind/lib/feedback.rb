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
    color_count = Hash.new(0)

    secret_code.each { |color| color_count[color] += 1 }

    guessed_code.each_with_index do |number, index|
      if secret_code[index] == number
        hits += 1
        color_count[number] -= 1
      end 
    end 

    guessed_code.each_with_index do |number, index|
      if secret_code[index] != number && color_count[number] > 0
        blows += 1
        color_count[number] -= 1
      end
    end 

    @current_blows_and_hits = [blows, hits]
  end 


  def check_if_win?(players, guess_counter)

    if self.current_blows_and_hits[1] == 4 
      players.guesser.win = true
      return true
      
    elsif guess_counter >= 15 #HIER GEÄNDERT
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
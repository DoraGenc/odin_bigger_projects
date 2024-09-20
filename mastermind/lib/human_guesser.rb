require_relative 'colors.rb'
require_relative 'guesser.rb'

class HumanGuesser < Guesser

  attr_reader :name, :type

  include Colors

  def initialize(name, type)
    super(name, type)
  end 
  
  def guess

    guessed_code = Array.new

    puts "\nHuman".bold.green + ", please guess a combination of colors."
    puts "In the following, please enter the Index of the color you want to choose.\n"
    puts "\nThose are all possible colors:\n "
  
    while guessed_code.length < 4
      valid_input = false

      until valid_input # Die Schleife fragt so lange den gleichen Tag ab, bis die Eingabe valid ist

        print_colors
        puts ("\nPlease choose your guess by entering the corresponding index number: ")
        single_guess = gets.chomp
            
        if single_guess.match?(/\A[0-5]\z/)
          guessed_code << single_guess.to_i
          valid_input = true
        else
          puts "Invalid input. Please enter an index number between 0 and 5. Do not type in letters or other characters."
        end
      end
    end 

    # geratene Index-Zahlen in Farben umwandeln
    guessed_colors = index_to_colors(guessed_code)
    TypingEffects.standard_typing("You guessed: #{guessed_colors}\n")

    return guessed_code
  end
end
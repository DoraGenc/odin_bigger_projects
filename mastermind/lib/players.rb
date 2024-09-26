require_relative 'speech.rb'

require_relative 'guesser.rb'
require_relative 'setter.rb'

require_relative 'human_guesser.rb'
require_relative 'computer_guesser.rb'
require_relative 'human_setter.rb'
class Players

  attr_reader :guesser, :setter

  include TypingEffects

  def initialize
    @guesser = nil
    @setter = nil
  end

  def choose_roles

    valid_input = false

    until valid_input
      puts "\nPlease set the Guesser.".yellow.bold
      puts "Is the Guesser a " + "Human (Enter \"1\")".green + " or a " + "Computer (Enter \"2\")".red + "?"
  
      input = gets.to_i

      case input
      when 1
        self.guesser = HumanGuesser.new("Human".green, "human")
        valid_input = true
        
      when 2
        self.guesser = ComputerGuesser.new("Computer".red, "computer")
        valid_input = true
      else
        TypingEffects.standard_typing("\nInvalid Input. Please only type in the integers 1 or 2.\n".red.bold)
        sleep(1)
        
      end 
    end 

    valid_input = false

    until valid_input
      puts "\nPlease set the Setter.".yellow.bold
      puts "Is the Setter a " + "Human (Enter \"1\")".green + " or a " + "Computer (Enter \"2\")".red + "?"
  
      input = gets.to_i
  
      case input
        when 1
           
          self.setter = HumanSetter.new("Human".green, "human")
          valid_input = true 
        when 2
          require_relative 'computer_setter.rb'
          self.setter = ComputerSetter.new("Computer".red, "computer") # ohne self funktioniert es nicht, trotz attr_writer?
          valid_input = true
        else
          TypingEffects.standard_typing("Invalid Input. Please only type in the integers 1 or 2.")
      end 
    end
    #TypingEffects.standard_typing("\nEverything set!\n".bold)
    #TypingEffects.standard_typing("You chose the Guesser to be a #{guesser.name} and the Setter to be a #{setter.name}!\n")
  end


  private

  attr_writer :guesser, :setter
end 
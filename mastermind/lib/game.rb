require_relative 'feedback.rb'
require_relative 'board.rb'
require_relative 'players.rb'
require_relative 'speech.rb'
require_relative 'colors.rb'

require 'colorize'

class Game

  attr_reader :players, :guess_counter, :feedback, :guesser, :setter, :board, :current_blows_and_hits, :turn_counter
  
  include Colors
  include TypingEffects


  def initialize

    @board = Board.new
    @feedback = Feedback.new
    @players = Players.new

    @guess_counter = 0
    @secret_code = "nichts"
    @guess = "leer"
    @current_blows_and_hits = "null"
  end

  def play_game #MUSS GEÄNDERT WERDEN 
    
    #first_dialogue
    #opening_dialogue

    win = false

    players.choose_roles
    players.setter.create
    secret_code = players.setter.created_code

    #puts "HERE COMES THE CODE: #{secret_code}"
  
    until win
      
     
      guess = players.guesser.guess # returned guessed_code aus def guess

      current_blows_and_hits = feedback.count_blows_and_hits(guess, secret_code)
      board.add_to_board!(guess, current_blows_and_hits, guess_counter)
      board.print_board(guess_counter)

      self.guess_counter = guess_counter + 1

      win = feedback.check_if_win?(players, guess_counter)
    end 
    announce_result
  end

  def announce_result

    if players.guesser.win
    TypingEffects.standard_typing("Congratulations, Guesser! " + "The winner is: " + "#{players.guesser.name}".bold.blue + "!\n")
    pause

      if players.setter.is_a?(ComputerSetter)
        print "Computer: ".bold.red
        TypingEffects.computer_typing("You CHEATER!! buuuäääääähhhhhhhh!! :(")
      end 
     
    else 
      TypingEffects.standard_typing("Congratulations, Setter! The winner is: " + "#{players.setter.name}".bold.yellow + "!\n")
      pause
    end
  end

  private

  attr_accessor :secret_code, :guess_counter, :board, :current_blows_and_hits, :feedback

end
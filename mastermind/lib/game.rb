require_relative 'feedback'
require_relative 'board'
require_relative 'players'
require_relative 'speech'
require_relative 'colors'
require 'colorize'

class Game

  include Colors
  include TypingEffects

  def initialize
    @board = Board.new
    @players = Players.new
    @feedback = Feedback.new

    @guess_counter = 0
    @secret_code = 'empty string'
    @guess = 'empty string'
    @current_blows_and_hits = 'empty'
  end

  def play_game
    # first_dialogue
    # opening_dialogue

    win = false

    players.choose_roles
    secret_code = players.setter.create #create könnte umbenenannt werden

    until win

      guess = players.guesser.guess(feedback.current_blows_and_hits)

      current_blows_and_hits = feedback.count_blows_and_hits(guess, secret_code)
      board.add_to_board!(guess, current_blows_and_hits, guess_counter)
      board.print_board(guess_counter)
      self.guess_counter = guess_counter + 1

      win = feedback.check_if_win?(players, guess_counter) #check_if_win? könnte win? heißen
    end
    announce_result
  end

  def determine_winner #könnte nach players verschoben werden

    if players.guesser.wins
      winner = players.guesser
    else
      winner = players.setter
    end
    return winner
  end


  def announce_result
      
    # standard output 
    winner = determine_winner

    if winner == players.guesser
      TypingEffects.standard_typing('Congratulations, Guesser! ' + "The Guesser wins".bold.blue + "!\n")
      pause
      
     else
      TypingEffects.standard_typing("Congratulations, Setter! " + "The Setter wins".bold.yellow + "!\n")
      pause
    end
  

    # comment?
    comment = players.is_human?(winner) #könnte nach players verschoben werden

    if comment
      print 'Computer: '.bold.red
      TypingEffects.computer_typing('You CHEATER!! buuuäääääähhhhhhhh!! :(')
    end 
  end 

  private

  attr_reader :players, :guesser, :setter
  attr_accessor :secret_code, :guess_counter, :board, :current_blows_and_hits, :feedback
end

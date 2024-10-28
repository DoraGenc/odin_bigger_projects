require_relative 'wordpicker.rb'
require 'colorize'

class Board

  def initialize
    @secret_word = []
    @current_state = []
  end

  def setup_secret_word
    wordpicker = Wordpicker.new
    picked_word = wordpicker.pick_word #funktioniert
    set_secret_word!(picked_word)

    # Debugging
    puts "PICKED WORD: #{picked_word}"
    puts "SECRET WORD: #{@secret_word}"
    initialize_current_state
  end

  def what_is_current_state
    current_state.join
  end

  def compare_guess(guess)
    index = find_index(guess)

    unless index == nil
      update_board!(index)
    end
  end

  def print_board
    puts "Current State: "
    print "#{what_is_current_state}"
  end

  private

  attr_accessor :secret_word, :current_state

  def set_secret_word!(picked_secret_word)
    self.secret_word = picked_secret_word
  end

  def find_index(guess)

    @secret_word.each_with_index do |letter, index|
      if letter == guess
        return index
      end
    end
    nil
  end

  def initialize_current_state
    number_of_columns = self.secret_word.length
    empty_column = "_"
    self.current_state = Array.new(number_of_columns, empty_column)
    puts what_is_current_state
  end

  def update_board!(index)
    secret_letter = secret_word[index]
    current_state[index] = secret_letter
  end
end

#board = Board.new
#board.print_board
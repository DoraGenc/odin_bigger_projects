require_relative 'wordpicker.rb'

class Board

  def initialize
    @secret_word = []
  end

  def create_secret_word
    wordpicker = Wordpicker.new
    @secret_word = wordpicker.pick_word
    p "SECRET WORD: "
    p secret_word
  end

  def print_board

    letter_count = secret_word.size

  

  end

  def correct_guess(guess)
    update_board!(find_index(guess))
  end

  private

  attr_accessor :secret_word

  def find_index(guess)

    @secret_word.each_with_index do |letter, index|
      if letter == guess
        return index
      end
    end
  end

  def update_board!(index)
  end
end
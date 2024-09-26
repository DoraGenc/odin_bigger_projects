require_relative 'feedback'

class Board
  def initialize
    @current_board = INITIAL_BOARD
    @blows_and_hits = Array.new(12) { %w[x x] }
  end

  def add_to_board!(guess, current_blows_and_hits, guess_counter)
    
    index = guess_counter
    current_board[index] = guess

    blows_and_hits[index] = current_blows_and_hits
  end

  def print_board(_guess_counter)
    header = '|   Blows   |   Hits    |    1    |    2    |    3    |    4    |'
    horizontal_separator = '-'
    vertical_separator = '|'
    column_width = 9

    puts "\n"
    puts "BOARD:\n"
    puts header
    puts horizontal_separator * header.length

    current_board.each_with_index.reverse_each do |row, row_index| #das reverse.each sorgt dafür, dass zuerst die letzte Zeile des Boards durchlaufen wird (mit 'x')
      print "|     #{blows_and_hits[row_index][0]}     |     #{blows_and_hits[row_index][1]}     "

      row.each do |guess|
        guess = guess.to_s

        empty_space = column_width - guess.length
        left_padding = empty_space / 2
        right_padding = empty_space - left_padding

        # Einzelne Spalten
        print "#{vertical_separator}#{' ' * left_padding}#{guess}#{' ' * right_padding}"
      end
      print vertical_separator
      puts "\n"
      puts horizontal_separator * header.length
    end
  end

  private

  attr_accessor :current_board, :blows_and_hits

  INITIAL_BOARD = [
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x],
    %w[x x x x]
  ]
end

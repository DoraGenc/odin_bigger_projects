require_relative 'feedback'

class Board

  HEADER = '|   Blows   |   Hits    |    1    |    2    |    3    |    4    |'
  HORIZONTAL_SEPERATOR = '-'
  VERTICAL_SEPERATOR = '|'
  COLUMN_WIDTH = 9

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
    print_header
    print_rows
  end


  def print_header

    puts "\n"
    puts "BOARD:\n"
    puts HEADER
    puts HORIZONTAL_SEPERATOR * HEADER.length
  end

  def print_rows

    current_board.each_with_index.reverse_each do |row, row_index| #das reverse.each sorgt dafür, dass zuerst die letzte Zeile des Boards durchlaufen wird (mit 'x')
      print "|     #{blows_and_hits[row_index][0]}     |     #{blows_and_hits[row_index][1]}     "

      row.each do |guess|
        guess = guess.to_s

        empty_space = COLUMN_WIDTH - guess.length
        left_padding = empty_space / 2
        right_padding = empty_space - left_padding

        # Einzelne Spalten
        print "#{VERTICAL_SEPERATOR}#{' ' * left_padding}#{guess}#{' ' * right_padding}"
      end
      print VERTICAL_SEPERATOR
      puts "\n"
      puts HORIZONTAL_SEPERATOR * HEADER.length
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

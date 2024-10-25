class Board

  def initialize
    @current_board = [
      ["1", "2", "3"],
      ["4", "5", "6"],
      ["7", "8", "9"]
  ]
  end 

  def print_board
    current_board.each_with_index do |row, index|
      puts row.join(' | ')
      puts "--+---+--" if index < current_board.length - 1
    end
  end

  def update_board!(chosen_field, mark_type)
    current_board.each_with_index do |row, row_index|
      row.each_with_index do |element, element_index|

        if element == chosen_field
          current_board[row_index][element_index] = mark_type
          return
        end
      end
    end
  end

  attr_reader :current_board
end 
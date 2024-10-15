class Board

  attr_reader :current_board

  def initialize(board)
    
    @current_board = board
    print_board
  end 


  def print_board
    @current_board.each_with_index do |row, index|
      puts row.join(' | ')
      puts "--+---+--" if index < @current_board.length - 1
    end
  end

  def update_board!(chosen_field)
    @current_board.each_with_index do |row, row_index|
      row.each_with_index do |element, element_index|
        if element == chosen_field
          @current_board[row_index][element_index] = @current_player.mark_type
          return
        end
      end
    end
  end
end 
require_relative 'board.rb'
require_relative 'typing_effects.rb'



class Game

  include TypingEffects

  def initialize(player1, player2)
    @turn_counter = 0
    @player1 = player1
    @player2 = player2

    @board = Board.new
    choose_first_player
  end

  def play_game

    board.print_board

    until win? || turn_counter >= 9

      check_and_choose_field
      self.turn_counter += 1
      switch_players!
      board.print_board

      unless win?
        puts "\nIt's #{current_player.name}'s turn!"
        break
      end
    end
    announce_result
  end 


  private

  attr_accessor :turn_counter, :current_player, :other_player, :winner, :board
  attr_reader :player1, :player2

  WINNING_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],  # Reihen
    [1, 4, 7], [2, 5, 8], [3, 6, 9],  # Spalten
    [1, 5, 9], [3, 5, 7]              # Diagonalen
  ]

  def choose_first_player
    if rand(1..2) == 1
      self.current_player = player1
      self.other_player = player2
    else
      self.current_player = player2
      self.other_player = player1
    end
    puts "\n#{current_player.name} goes first!"
  end

  def check_and_choose_field
    puts "Please choose a free field between (1-9) to place your mark (#{@current_player.mark_type}): "
    chosen_field = nil

    until valid_field?(chosen_field)
      chosen_field = gets.chomp

      unless valid_field?(chosen_field)
        puts "Your input is invalid or the field is already taken. Please enter a different number between 1-9: "
      end
    end
    board.update_board!(chosen_field, @current_player.mark_type)
  end

  def valid_field?(input)
    board.current_board.flatten.include?(input)
  end

  def win?
    flat_board = board.current_board.flatten

    [player1, player2].each do |player|
      WINNING_COMBINATIONS.each do |winning_combo|

        a, b, c = winning_combo.map { |index| flat_board[index - 1] } # -1, weil der Index bei Ruby mit 0 anfängt
        if a == player.mark_type && b == player.mark_type && c == player.mark_type
          
          self.winner = player
          return true
        end
      end
    end
    false
  end
  

  def announce_result

    if win? 
        TypingEffects.yellow_typing("\n#{self.winner.name} wins!")
    else 
      puts "It's a draw!"
    end
  end

  def switch_players!
    self.current_player, self.other_player = self.other_player, self.current_player
  end
end
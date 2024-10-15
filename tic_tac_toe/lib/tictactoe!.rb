
require 'colorize'
module TypingEffects

  def self.standard_typing(string)
    
    string.each_char do |char|
      print char    
      sleep(rand(0.04..0.07))
    end
  end

  def self.slow_steady_typing(string)

    string.each_char do |char|
      print char
      sleep(0.3)
    end
  end

  def self.very_slow_typing(string)

    string.each_char do |char|
      print char
      sleep(0.5)
    end
  end

  def self.yellow_typing(string)

    string.each_char do |char|
      print char.yellow
      sleep(rand(0.01..0.03))
    end
  end

  def self.evil_typing(string)

    string.each_char do |char|
      print char.red
      sleep(0.2)
    end
  end

  def self.red_typing(string)

    string.each_char do |char|
      print char.red
      sleep(rand(0.04..0.07))
    end
  end

  def self.narrator2_typing(string)

    string.each_char do |char|
    print char.blue
    sleep(0.03)
    end
  end
end

class Player
  attr_reader :name, :mark_type

  def initialize(name, mark_type)
    @name = name
    @mark_type = mark_type
  end
end


class Board

  INITIAL_BOARD = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"]
  ]

  def initialize
    @current_board = INITIAL_BOARD
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


class Game

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

    if win? #anders 
        TypingEffects.yellow_typing("\n#{self.winner.name} wins!")
    else 
      puts "It's a draw!"
    end
  end

  def switch_players!
    self.current_player, self.other_player = self.other_player, self.current_player
  end
end


# Spieler erstellen und das Spiel starten

TypingEffects.standard_typing("Player 1, please set your name!\nName:")
player1_name = gets.chomp

TypingEffects.standard_typing("Now you, Player 2! Please set your name.\nName: ")
player2_name = gets.chomp

player1 = Player.new(player1_name, "X")
player2 = Player.new(player2_name, "O")

game1 = Game.new(player1, player2)
game1.play_game


# #self => Um eine Instanzvariable aufzurufen und keine neue Variable zu erstellen
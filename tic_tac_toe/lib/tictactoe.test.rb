
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

  def self.scared_typing(string)

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

class Game

  INITIAL_BOARD = [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"]
  ]

  WINNING_COMBINATIONS = [
    [1,2,3], [4,5,6], [7,8,9],  # Reihen
    [1,4,7], [2,5,8], [3,6,9],  # Spalten
    [1,5,9], [3,5,7]            # Diagonalen
  ]

  attr_reader :current_board, :turn_counter, :current_player, :other_player, :winner

  def initialize(player1, player2)  #1. keine @ bei instanzvariablen außer initialize, keine unbenutzen attr_reader
                                    #2. nur instanzvariablen im initialize
    @current_board = INITIAL_BOARD  #3. Hier fehlt eine Klasse (Boardklasse)
    @turn_counter = 0
    @player1 = player1
    @player2 = player2s
    choose_first_player #das ist ok

    play_game
    announce_result
  end


  def choose_first_player

    decide_randomly = rand(1..2) #unnötig
    
    if decide_randomly == 1
      @current_player = @player1
      @other_player = @player2
    else
      @current_player = @player2
      @other_player = @player1
    end
    puts "#{@current_player.name} goes first!"
  end


  def play_game

    until win? || @turn_counter >= 9
      print_board
      check_and_choose_field
      @turn_counter += 1
      switch_players!
    end
    print_board
  end 


  def print_board
    @current_board.each_with_index do |row, index|
      puts row.join(' | ')
      puts "--+---+--" if index < @current_board.length - 1
    end
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
    update_board!(chosen_field)
  end


  def valid_field?(input)
    number = input.to_i
    @current_board.flatten.include?(input)
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


  def win?
    flat_board = @current_board.flatten

    WINNING_COMBINATIONS.each do |combo|
      a, b, c = combo.map { |index| flat_board[index - 1] } # -1 weil der Index bei 0 beginnt

      if a == "X" && b == "X" && c == "X" #die Buchstaben stehen hier also für Index-Zahlen
        @winner = @player1
        return true
      elsif a == "O" && b == "O" && c == "O"
        @winner = @player2
        return true
      end
    end
    false
  end


  def announce_result
    if win?
      puts "#{@winner.name} wins!"
    elsif @turn_counter >= 9
      puts "It's a draw!"
    end
  end


  def switch_players!
    @current_player, @other_player = @other_player, @current_player
  end
end


player1 = Player.new("Player 1", "X")
player2 = Player.new("Player 2", "O")

Game.new(player1, player2)













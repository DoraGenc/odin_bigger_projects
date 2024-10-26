
require_relative 'strawberrycat.rb'
require_relative 'board.rb'

class Game

  def initialize(player1, player2)
    @turn_counter = 0
    @player = player
    @cat = StrawberryCat.new
    @board = Board.new
  end

  def play_game

    
  end 

private
end
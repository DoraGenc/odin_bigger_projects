require_relative 'game.rb'
require_relative 'typing_effects.rb'
require_relative 'player.rb'

TypingEffects.standard_typing("Player 1, please set your name!\nName:")
player1_name = gets.chomp

TypingEffects.standard_typing("Now you, Player 2! Please set your name.\nName: ")
player2_name = gets.chomp

player1 = Player.new(player1_name, "X")
player2 = Player.new(player2_name, "O")

game1 = Game.new(player1, player2)
game1.play_game
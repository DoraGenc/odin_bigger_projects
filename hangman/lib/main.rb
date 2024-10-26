#require_relative "../spec/player.rb"
require 'colorize'
require_relative 'player.rb'

def space
  puts ""
end

def welcome
  puts "Hello " + "Player".cyan + "!"
  puts "Welcome to..."
  sleep(1)
  print "BEAT"; sleep(1); print " THE ";sleep(1); print" STRAWBERRY CAT".red + "!!"
  sleep(1)
end

welcome; space

TypingEffects.standard_typing("Player, please set your name!\nName:")
player_name = gets.chomp

player1 = Player.new(player_name)
game = Game.new(player1)
game.play_game

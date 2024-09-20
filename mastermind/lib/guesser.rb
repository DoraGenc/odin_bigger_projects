require_relative 'players.rb'

class Guesser < Players

  attr_accessor :win
  attr_reader :name

  def initialize(name, type)
    @name = name
    @type = type
    @win = false
  end 
end 
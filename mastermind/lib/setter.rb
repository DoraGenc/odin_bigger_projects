require_relative 'players.rb'

class Setter

  attr_accessor :win
  attr_reader :name, :type

  def initialize(name, type)
    @name = name
    @type = type
    @win = false
  end 

  def create(_empty)
  end
end
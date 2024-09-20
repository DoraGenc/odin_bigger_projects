require_relative 'players.rb'

class Setter < Players

  attr_accessor :win
  attr_reader :name

  def initialize(name, type)
    @name = name
    @type = type
    @win = false
  end 

  private

  attr_writer :secret_code
end
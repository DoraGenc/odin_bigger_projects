require_relative 'guesser.rb'
require_relative 'code_breaker/code_breaker.rb'
require_relative 'game.rb'

class ComputerGuesser < Guesser

  attr_reader :name, :type
  
  def initialize(name, type)
    super(name, type)

    @code_breaker = CodeBreaker.new
  end 
  
  def guess

    code_breaker.receive_new_feedback(game.feedback.current_blows_and_hits)
    guess = code_breaker.return_guess

    return guess
  end 
end
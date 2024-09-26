require_relative 'guesser.rb'
require_relative 'code_breaker/code_breaker.rb'

class ComputerGuesser < Guesser
  
  def initialize(name, type)
    super(name, type)

    @code_breaker = CodeBreaker.new
  end 
  
  def guess(current_blows_and_hits)

    created_guess = code_breaker.guess(current_blows_and_hits)

    return created_guess
  end 

  private

  attr_reader :code_breaker, :feedback
end
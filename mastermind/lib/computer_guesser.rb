require_relative 'guesser'
require_relative 'code_breaker/code_breaker'

class ComputerGuesser < Guesser
  def initialize(name, type)
    super(name, type)
    @code_breaker = CodeBreaker.new
  end

  def guess(current_blows_and_hits)
    code_breaker.guess(current_blows_and_hits)
  end

  private

  attr_reader :code_breaker, :feedback
end

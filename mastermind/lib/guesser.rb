class Guesser
  attr_accessor :win
  attr_reader :name, :type

  def initialize(name, type)
    @name = name
    @type = type
    @win = false
  end
end

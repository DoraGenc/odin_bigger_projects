require_relative 'setter'

class ComputerSetter < Setter
  attr_reader :name, :type, :created_code

  def initialize(name, type)
    super(name, type)
  end

  def create
    created_code = Array.new(4) { (0..5).to_a.sample }
    self.created_code = created_code

    puts "SECRET CODE IS: #{created_code}"
  end

  private

  attr_writer :created_code
end

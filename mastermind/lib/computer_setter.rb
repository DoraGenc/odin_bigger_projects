
require_relative 'setter.rb'

class ComputerSetter < Setter

  attr_reader :name, :type, :created_code
  
  def initialize(name, type)
    super(name, type)
    @created_code
  end 
  
  def create
    created_code = Array.new(4) { (0..5).to_a.sample } # 0-7 repräsentiert die Index-Zahlen von COLORS
    puts "SECRET CODE IS: #{created_code}"
    self.created_code = created_code #wieso geht das nur mit self???
  end

  private

  attr_writer :created_code
end
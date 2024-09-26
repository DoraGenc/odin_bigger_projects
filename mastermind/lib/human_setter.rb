
require_relative 'setter.rb'
require_relative 'colors.rb'
require_relative 'speech.rb'

class HumanSetter < Setter

  attr_reader :name, :type, :created_code

  include Colors
  include TypingEffects
  
  def initialize(name, type)
    super(name, type)
    @created_code
  end 
  
  def create
    
    created_code = Array.new
    #TypingEffects.standard_typing("Hi " + "Human! ".bold.green + "Please create your Secret Code. You can type in 4 colors.\nThose are the colors you can choose from:\n\n"); pause
    print_colors
    pause(1)

    while created_code.length < 4
      puts "\nPlease type in the index number: "
      single_secret_index = gets.chomp
  
      if single_secret_index.match?(/\A[0-7]\z/)
        created_code << single_secret_index.to_i
        self.created_code = created_code
      else
        puts "Invalid input. Please enter an index number between 0 and 7. Do not type in letters or other characters.".red
      end
    end

    TypingEffects.standard_typing("You created the code: ")
    print index_to_colors(self.created_code)
    pause(1)

    created_code
  end

  private
    
    attr_writer :created_code
end 
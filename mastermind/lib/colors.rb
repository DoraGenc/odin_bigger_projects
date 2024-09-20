require 'colorize'

module Colors
    
  COLORS = ['black', 'red', 'green', 'yellow', 'blue', 'magenta']

  def print_colors
    COLORS.each_with_index do |color, index|
      puts "Color: " + "#{color}".colorize(color.to_sym) + ", Index:" + "#{index}".colorize(color.to_sym)
    end
  end

  def index_to_colors(index_array)

    colors_array = Array.new
  
    index_array.map do |index|
      
      color_name = COLORS[index]
      color_name = color_name.colorize(:color => color_name.to_sym)
      colors_array << color_name
    end 
    colors_array.join(', ') #Es lag an dem join!
  end 
end 
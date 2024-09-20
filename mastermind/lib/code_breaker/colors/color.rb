

class Color

  attr_reader :color_index
  attr_accessor :included, :excluded, :left, :right, :first_lc, :second_lc, :first_rc, :second_rc, :quantity

  def initialize(color_index)

    @color_index = color_index
    
    @quantity = nil

    @included = nil
    @excluded = nil

    @left = nil
    @right = nil

    @first_lc = nil
    @second_lc = nil

    @first_rc = nil
    @second_rc = nil
  end
end
class Node
  attr_accessor :left_children, :right_children, :value

  def initialize(left_children = nil, right_children = nil, value = nil)
    @left_children = left_children
    @right_children = right_children
    @value = value
  end
end
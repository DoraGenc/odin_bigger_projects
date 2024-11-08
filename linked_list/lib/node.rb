class Node
  attr_accessor :next_node
  attr_reader :data

  def initialize(data = nil)
    @data = data
    @next_node = nil
  end
end
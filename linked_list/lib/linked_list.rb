require_relative '../lib/node.rb'

class LinkedList

  attr_reader :head

  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)

    if head.nil?
      set_head(new_node)
    else
      current_node = head
      current_node = current_node.next_node while current_node.next_node #wird beendet, wenn next_node = nil (standardmäßig nil)
      current_node.next_node = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value)

    if head.nil?
      set_head(new_node)
    else
      current_node = head
      current_node = current_node.next_node while current_node.next_node #wird beendet, wenn next_node = nil (standardmäßig nil)
      current_node.next_node = new_node
    end
  end

  def size
    current_node = head
    counter = 0
    
    while current_node
      counter += 1
      current_node = current_node.next_node
    end
    counter
  end

  def tail

    unless head.nil?
      current_node = head
      current_node = current_node.next_node while current_node.next_node #wird beendet, wenn next_node = nil (standardmäßig nil)
      return current_node
    end
    nil
  end

  def at(index)
    return nil if index < 0
    current_node = head

    index.times do
      if current_node.next_node.nil?
        return nil
      else
        current_node = current_node.next_node
      end
    end
    current_node
  end

  def pop!
    current_node = head
    current_node = current_node.next_node while current_node.next_node
    current_node.value
    current_node = nil
  end



  private

  attr_writer :head

  def set_head(node)
    @head = node
  end
end
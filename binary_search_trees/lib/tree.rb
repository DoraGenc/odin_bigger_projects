require_relative "node.rb"

class Tree
  attr_reader :root, :binary_tree_values

  def initialize(binary_tree_values = [])
    @binary_tree_values = format(binary_tree_values)
    @root = build_tree(self.binary_tree_values)
    @formatted = false
  end

  def build_tree(node_value_array = binary_tree_values)
    return nil if node_value_array.empty? || node_value_array.nil?
    node_value_array = format(node_value_array) unless formatted
    self.binary_tree_values = node_value_array if binary_tree_values.length == 0

    mid_index = node_value_array.length / 2  
    mid_value = node_value_array[mid_index]

    node = Node.new(nil, nil, mid_value)
    
    node.left_children = build_tree(node_value_array[0...mid_index])
    node.right_children = build_tree(node_value_array[mid_index + 1..])
    
    root = node
    return root
  end

  def tree_pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_children, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_children
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_children, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_children
  end

  def find_node(value, current_node = root)
    return "Invalid value. Please only choose positive Integers or Floats." unless valid_value?(value)
    found_node = find_node_by_value(value, current_node)
    return found_node if found_node
  end

  def node_exists?(value)
    return false if root.nil?
    return nil if value.nil?

    found_value = find_node_by_value(value)
    return false if found_value.nil?
    return true if found_value.value == value
    false
  end

  def nodes_exist?(values_array)
    return false if root.nil?
    return nil if values_array.nil?

    true_counter = 0

    values_array.each do |value|
      return nil if value.nil?

      found_node = find_node_by_value(value)

      return false unless found_node && found_node.value == value
      true_counter += 1 
    end

    true
  end
  
  def insert(value) #als leaf
    return nil unless root
    return "Invalid value. Please only choose positive Integers or Floats." unless valid_value?(value)
    return "node already exists" if node_exists?(value)
    parent =  node_to_append_leaf(value)

    append_new_node(value, parent) unless parent.nil?
  end

  def delete(value)
    return "The given value does not exist." unless node_exists?(value)
    
    parent = parent_node(value)
    node_to_delete = find_node_by_value(value)
    direction_of_node_to_delete = right_or_left(value, parent) #vom parent aus
  

    case how_many_children(node_to_delete)[:count] #value für count extrahieren
    when 0
      delete_children(parent, direction_of_node_to_delete)
    when 1
      children_of_node_to_delete = node_to_delete.left_children || node_to_delete.right_children #kann nur 1 child haben
      parent.send("#{direction_of_node_to_delete}_children=", children_of_node_to_delete)  # also beispielsweise: parent.left_children = children
    when 2
      remove_node_with_two_children(node_to_delete)
    end
  end

  def level_order_traversal #immer die ganze ebene erst
    return nil unless root
    return "no block given" unless block_given?

    queue = [root]
    results = []

    while !queue.empty?
      current_node = queue.shift #shift: 1. element entfernen & returnen
      results << yield(current_node.value)

      queue.push(current_node.left_children) if current_node.left_children
      queue.push(current_node.right_children) if current_node.right_children
    end

    results
  end

  def inorder_traversal #links wurzel rechts
    return nil unless root
    return "no block given" unless block_given?

    stack = []
    results = []
    current_node = root

    while current_node || !stack.empty?
      while current_node #bis es kein linkes child mehr gibt
        stack.push(current_node) #wurzel hinzufügen (hinten)
        current_node = current_node.left_children #links bearbeiten
      end

      current_node = stack.pop #letztes element entfernen & returnen
      results << yield(current_node.value)

      current_node = current_node.right_children
    end

    results
  end

  def preorder_traversal(current_node = root, result = [], &block) #wurzel links recht
    return unless current_node
    return "no block given" unless block_given?
  
    result << yield(current_node.value)

    preorder_traversal(current_node.left_children, result, &block)
    preorder_traversal(current_node.right_children, result, &block)

    result
  end

  def postorder_traversal(current_node = root, result = [], &block) #links rechts wurzel
    return nil unless current_node
    return "no block given" unless block_given?

    postorder_traversal(current_node.left_children, result, &block)
    postorder_traversal(current_node.right_children, result, &block)

    result << yield(current_node.value)
  end

  def height(current_node = root, counted_height = 0) #längster pfad wird bestimmt
    return nil unless root
    return counted_height if current_node.nil?
  
    left_height = height(current_node.left_children, counted_height + 1)
    right_height = height(current_node.right_children, counted_height + 1)

    [left_height, right_height].max
  end
  
  def depth(searched_node, current_node = root, counted_depth = 0) #pfad bis zu einem node wird bestimtm
    return nil unless current_node
    return nil unless node_exists?(searched_node.value)
  
    return counted_depth if current_node == searched_node
  
    if searched_node.value < current_node.value
      depth(searched_node, current_node.left_children, counted_depth + 1)
    else
      depth(searched_node, current_node.right_children, counted_depth + 1)
    end
  end

  def balanced?(tree_root = root)
    return nil unless root
    
    right_height = height(root.right_children)
    left_height = height(root.left_children)

    difference = right_height - left_height

    return true if difference == 0 || difference == 1
    false
  end

  def balance!
    return "The tree is empty. It can not be balanced." if root.nil?
    return if balanced?

    self.root = build_tree(extract_values(root))
  end

  def extract_values(current_node = root, values_array = [])
    return nil unless current_node
    return values_array if current_node.nil?

    values_array << current_node.value

    extract_values(current_node.left_children, values_array)
    extract_values(current_node.right_children, values_array)

    return values_array
  end
  
  private

  attr_writer :root, :binary_tree_values
  attr_accessor :formatted

  def format(array)
    self.formatted = true
    return [] if array.empty?
    array.flatten.sort.uniq
  end

  def valid_value?(value)
    return false if !(value.is_a?(Integer) || 
                    value.is_a?(Float)) || 
                    value.nil? || 
                    value < 0 
    true
  end

  def find_node_by_value(value, node = root)
    return nil if node.nil?
    return node if node.value == value

    if value < node.value
      return find_node_by_value(value, node.left_children)
    else
     return find_node_by_value(value, node.right_children)
    end
  end

  def node_to_append_leaf(value, node = root)
    return nil if node.nil?
    return node if node.value == value

    if value < node.value
      if node.left_children.nil?
        return node #gefunden
      else
        return node_to_append_leaf(value, node.left_children)
      end

    else
      if node.right_children.nil?
        return node #gefunden
      else
        return node_to_append_leaf(value, node.right_children)
      end
    end
  end

  def right_or_left(value, node)
    return nil if value.nil? || node.nil?

    if value < node.value
      return "left"
    elsif value > node.value
      return "right"
    elsif value == node.value
      return "value equals node value"
    end

    nil
  end

  def append_new_node(value, node)
    new_node = Node.new(nil, nil, value)

    if right_or_left(value, node) == "left"
      node.left_children = new_node
    else 
      node.right_children = new_node
    end
  end

  def parent_node(value, node = root)
    return nil if node.nil?

    #base case
    if (node.left_children && node.left_children.value == value) ||
      (node.right_children && node.right_children.value == value)
     return node
   end
    
    direction = right_or_left(value, node)

    if direction == "right"
      parent_node(value, node.right_children)
    elsif direction == "left"
      parent_node(value, node.left_children)
    else
      "no direction"
    end
  end

  def next_biggest_number(node)
    return nil if node.nil? || node.right_children.nil?
  
    current_node = node.right_children
  
    while current_node.left_children #nächstgrößte wert ist links
      current_node = current_node.left_children
    end
  
    return current_node
  end

  def how_many_children(node)
    return nil if node.nil?

    children = { count: 0, directions: [] }

    if node.left_children
      children[:count] += 1
      children[:directions] << "left"
    end
  
    if node.right_children
      children[:count] += 1
      children[:directions] << "right"
    end
  
    children
  end

  def delete_children(parent, direction)

    if direction == "right"
      parent.right_children = nil

    else
      parent.left_children = nil
    end
  end

  def remove_node_with_two_children(node_to_delete)

    #1. den nächstgrößten Wert finden
    current_node = node_to_delete.right_children

    while current_node.left_children
      current_node = current_node.left_children
    end

    next_larger_node = current_node
    parent = parent_node(next_larger_node.value)
    
    # den value des nodes zum löschen ersetzen mit dem gefundenen value
    node_to_delete.value = next_larger_node.value

    # den parent auf die rechten children pointen des nodes, von dem der wert getauscht wurde
    parent.right_children = next_larger_node.right_children
  end
end
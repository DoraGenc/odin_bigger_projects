def find_node(value)
  current_node = root
  return nil if current_node.nil?
  
  if valid_value?(value)
    while current_node
      pp current_node.value
  
      if value < current_node.value
        return current_node if current_node.left_children.nil?
        current_node = current_node.left_children

      elsif value > current_node.value
        return current_node if current_node.right_children.nil?
        current_node = current_node.right_children

      else
        # Wert gefunden, gib den aktuellen Node zurück
        return current_node
      end
    end
  end

  "Invalid value. Please only choose positive Integers or Floats."
end




if direction == "left"
  pp "left"
  left_orphaned_children = parent.left_children.left_children if parent.left_children
  right_orphaned_children = parent.right_children.right_children if parent.right_children
  
  pp left_orphaned_children

  parent.left_children = left_orphaned_children
  parent.right_children = right_orphaned_children

  
elsif direction == "right"
  pp "right"
  left_orphaned_children = parent.left_children.left_children if parent.left_children
  right_orphaned_children = parent.right_children.right_children if parent.right_children

  parent.left_children = left_orphaned_children
  parent.right_children = right_orphaned_children

elsif direction == "value equals node value"
  parent = nil
end





true_counter = 0

value_array.each do |value|
  true_counter += 1 if last_node(value).value == value
end

return false if true_counter = 0
true_counter
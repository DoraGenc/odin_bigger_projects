require_relative "../lib/tree.rb"

RSpec.describe Tree do

  describe "#build_tree" do
    context "when building a small tree" do
      it "returns nil if the array is empty or the argument is nil (base case)" do
        sorted_array = []
        tree = Tree.new(sorted_array)
        
        expect(tree.build_tree(sorted_array)).to eq(nil)
      end

      it "makes it the root of the tree" do
        unsorted_array = [2, 1, 3]
        tree = Tree.new(unsorted_array)

        expect(tree.root).not_to eq(nil)
      end

      it "sets the correct value for the root" do
        unsorted_array = [2, 1, 3]
        tree = Tree.new(unsorted_array)
        root_value = 2

        expect(tree.root.value).to eq(2)
      end

      context "when calling itsself recursively" do
        it "calls itsself the right amount of times" do
          unsorted_array = [2, 1, 3]
          tree = Tree.new(unsorted_array)
          allow(tree).to receive(:build_tree).and_call_original
          tree.build_tree

          expect(tree).to have_received(:build_tree).exactly(7).times
        end

        it "sets the children values of the last nodes to nil" do
          unsorted_array = [2, 1, 3]
          tree = Tree.new(unsorted_array)
          
          expect(tree.root.left_children.left_children).to eq(nil)
          expect(tree.root.right_children.right_children).to eq(nil)
        end

        it "does not return nil if the array is not empty" do
          tree = Tree.new([])
          sorted_array = [1]

          expect(tree.build_tree(sorted_array)).not_to eq(nil)
        end

        context "when the given array is unsorted" do
          it "balances the tree correctly" do
            unsorted_array = [3, 1, 2]
            tree = Tree.new([])

            root = tree.build_tree(unsorted_array)

            expect(root.value).to eq(2)
            expect(root.left_children.value).to eq(1)
            expect(root.right_children.value).to eq(3)
          end
        end

        context "when the given array is sorted" do
          it "balances the tree correctly" do
            unsorted_array = [1, 2, 3]
            tree = Tree.new([])

            root = tree.build_tree(unsorted_array)

            expect(root.value).to eq(2)
            expect(root.left_children.value).to eq(1)
            expect(root.right_children.value).to eq(3)
          end
        end

        context "when the array only contains one element" do
          it "makes it the tree's root" do
            sorted_array = [1]
            tree = Tree.new(sorted_array)

            expect(tree.root.value).to eq(1)
          end
        end
      end
    end

    context "when building bigger trees" do
      it "builds a tree for a large array" do
        unsorted_array = (1..100).to_a.shuffle
        tree = Tree.new(unsorted_array)
      
        expect(tree.root).not_to eq(nil)
        expect(tree.root.left_children).not_to eq(nil)
        expect(tree.root.right_children).not_to eq(nil)
      end
    end

    context "when binary_tree_values is empty" do
      it "assigns the given array to binary_tree_values" do
        tree = Tree.new
        tree.build_tree([1])
        expect(tree.binary_tree_values).to eq([1])
      end
    end
  end

  describe "#find_node" do
    context "when a tree exists" do
      let(:tree) { described_class.new([1, 2, 3])}

      context "when the value is invalid" do
        it "returns an error" do
          invalid_value = -1
          expect(tree.find_node(invalid_value)).to eq("Invalid value. Please only choose positive Integers or Floats.")
        end
      end

      context "when the value is valid" do
        it "returns the correct node" do
          searched_value = 3
          returned_node = tree.find_node(searched_value)

          expect(returned_node.value).to eq(3)
        end
      end

      context "when the node to return would be the root" do
        it "returns the root" do
          searched_value = 2
          returned_node = tree.find_node(searched_value)

          expect(returned_node).to eq(tree.root)
        end
      end

      context "when the root is nil" do
        it "returns nil" do
          empty_tree = Tree.new
          non_existent_value = 1
          expect(empty_tree.find_node(non_existent_value)).to eq(nil)
        end
      end

      context "when the tree is larger" do
        it "returns the correct node" do
          large_tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9])

          searched_value = 9
          returned_node =  large_tree.find_node(searched_value)

          expect(returned_node.value).to eq(searched_value)
        end
      end

      context "when the value is not assigned to a node" do
        it "returns nil" do
          non_existent_value = 10
          expect(tree.find_node(10)).to eq(nil)
        end
      end
    end
  end

  describe "#insert" do
    let(:tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when the value is invalid" do
      context "when the value is nil" do
        it "returns an error" do
          invalid_value = nil
          expect(tree.insert(invalid_value)).to eq("Invalid value. Please only choose positive Integers or Floats.")
        end
      end

      context "when the value is smaller than 0" do
        it "returns an error" do
          invalid_value = -1
          expect(tree.insert(invalid_value)).to eq("Invalid value. Please only choose positive Integers or Floats.")
        end
      end
    end

    context "when the value is valid" do
      context "when the value is an Integer" do
        it "does not return an error" do
          valid_value = 1
          expect(tree.insert(valid_value)).not_to eq("Invalid value. Please only choose positive Integers or Floats.")
        end
      end

      context "when the value is a Float" do
        it "does not return an error" do
          valid_value = 1.5
          expect(tree.insert(valid_value)).not_to eq("Invalid value. Please only choose positive Integers or Floats.")
        end
      end

      context "when adding a leaf" do
        it "adds a node with the correct value" do
          tree.insert(2.5)

          expect(tree.node_exists?(2.5)).to eq(true)
        end

        it "links a child to the right node" do
          tree.insert(2.5)

          target_node_value = tree.root.left_children.left_children.right_children.value
          expect(target_node_value).to eq(2.5)
        end
      end

      context "when trying to append and already existing value" do
        it "does not change anything" do
          previous_root = tree.root
          tree.insert(8)

          new_root = tree.root
          expect(previous_root).to eq(new_root)
        end
      end
    end

    context "when the root is nil" do
      it "returns nil" do
        empty_tree = Tree.new

        expect(empty_tree.insert(1)).to eq(nil)
      end
    end

    context "when a node already exists" do
      before do
        allow(tree).to receive(:append_new_node).and_call_original
      end

      it "returns an error" do
        already_existing_value = 1
        expect(tree.insert(already_existing_value)).to eq("node already exists")
      end

      it "does not append a leaf" do
        already_existing_value = 1
        tree.insert(already_existing_value)

        expect(tree).not_to have_received(:append_new_node)
      end
    end
  end

  describe "#node_exists?" do
    let(:tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when the given value is nil" do
      it "returns nil" do
        expect(tree.node_exists?(nil)).to eq(nil)
      end
    end

    context "when a value is assigned to a node" do
      it "returns true" do
        expect(tree.node_exists?(5)).to eq(true)
      end
    end

    context "when a value is not assigned to a node" do
      it "returns false" do
        expect(tree.node_exists?(0)).to eq(false)
      end
    end

    context "when a root does not exist" do
      it "returns false" do
        empty_tree = Tree.new
        expect(empty_tree.node_exists?(1)).to eq(false)
      end
    end
  end

  describe "#nodes_exist?" do
    let(:tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when the given value is nil" do
      it "returns nil" do
        expect(tree.nodes_exist?(nil)).to eq(nil)
      end
    end

    context "when any given value is nil" do
      it "returns nil" do
        invalid_values_array = [1, nil, 3]
        expect(tree.nodes_exist?(invalid_values_array)).to eq(nil)
      end
    end

    context "when a root does not exist" do
      it "returns false" do
        empty_tree = Tree.new
        values_array = [1, 2, 3]
        expect(empty_tree.nodes_exist?(values_array)).to eq(false)
      end
    end

    context "when all values are assigned to a node" do
      it "returns true" do
        existing_values = [1, 2, 3]
        expect(tree.nodes_exist?(existing_values)).to eq(true)
      end
    end

    context "when any value is not assigned to a node" do
      it "returns false" do
       array_with_not_assigned_value = [1, 2, 10]
       expect(tree.nodes_exist?(array_with_not_assigned_value)).to eq(false)
      end
    end
  end

  describe "#delete" do
    let(:tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when the value does not exist" do
      it "returns an error" do
        expect(tree.delete(10)).to eq("The given value does not exist.")
      end
    end

    context "when the node has no children" do
      it "deletes the node" do
        tree.delete(1)
        expect(tree.node_exists?(1)).to eq(false)
      end

      it "only deletes the child with the given value" do
        small_tree = Tree.new([1, 2, 3])
        small_tree.delete(1)
        expect(small_tree.nodes_exist?([2, 3])).to eq(true)
      end
    end

    context "when the node has one child" do
      it "deletes the node" do
        tree.delete(2)
        expect(tree.node_exists?(2)).to eq(false)
      end

      it "does not delete its child" do
        tree.delete(2)
        expect(tree.node_exists?(1)).to eq(true)
      end
    end

    context "when the node has two children" do
      it "deletes the node" do
        tree.delete(8)
        expect(tree.node_exists?(8)).to eq(false)
      end

      it "does not delete any other nodes" do
        tree.delete(3)
        expect(tree.nodes_exist?([1, 2, 4, 5, 6, 7, 8, 9])).to eq(true)
      end
    end
  end

  describe "#level_order_traversal" do
    let(:tree) { described_class.new([1, 2, 3]) }
    let(:deep_tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when a block is given" do
      context "when the root is nil" do
        it "returns nil" do
          empty_tree = Tree.new
          expect(empty_tree.level_order_traversal).to eq(nil)
        end
      end

      it "calls the block" do
        expect { |b| tree.level_order_traversal(&b) }.to yield_control
      end

      it "returns the results of the block with all of the node's values & in the right order" do
        expected_result = [1, 0, 2]
        expect(tree.level_order_traversal {|value| value -= 1 }).to eq(expected_result)
      end

      context "when the tree has a deep structure" do
        it "returns the correct result in the correct order" do
          expected_result = [4, 2, 7, 1, 3, 6, 8, 0, 5]
          expect(deep_tree.level_order_traversal {|value| value -= 1 }).to eq(expected_result)
        end
      end
    end

    context "when a block is not given" do
      it "returns an error" do
        expect(tree.level_order_traversal).to eq("no block given")
      end
    end
  end

  describe "#inorder_traversal" do
    let(:tree) { described_class.new([1, 2, 3]) }
    let(:deep_tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when a block is given" do
      context "when the root is nil" do
        it "returns nil" do
          empty_tree = Tree.new
          expect(empty_tree.inorder_traversal).to eq(nil)
        end
      end

      it "calls the block" do
        expect { |b| tree.inorder_traversal(&b) }.to yield_control
      end

      it "returns the results of the block with all of the node's values & in the right order" do
        expected_result = [0, 1, 2]

        expect(tree.inorder_traversal{|value| value -= 1 }).to eq(expected_result)
      end

      context "when the tree has a deep structure" do
        it "returns the correct result in the correct order" do
          expected_result = [0, 1, 2, 3, 4, 5, 6, 7, 8]

          expect(deep_tree.inorder_traversal {|value| value -= 1 }).to eq(expected_result)
        end
      end
    end

    context "when a block is not given" do
      it "returns an error" do
        expect(tree.inorder_traversal).to eq("no block given")
      end
    end
  end

  describe "#preorder_traversal" do
    let(:tree) { described_class.new([1, 2, 3]) }
    let(:deep_tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when a block is given" do
      context "when the root is nil" do
        it "returns nil" do
          empty_tree = Tree.new
          expect(empty_tree.preorder_traversal).to eq(nil)
        end
      end

      it "calls the block" do
        expect { |b| tree.preorder_traversal(&b) }.to yield_control
      end

      it "returns the results of the block with all of the node's values & in the right order" do
        expected_result = [1, 0, 2]
 
        expect(tree.preorder_traversal{|value| value -= 1 }).to eq(expected_result)
      end

      context "when the tree has a deep structure" do
        it "returns the correct result in the correct order" do
          expected_result = [4, 2, 1, 0, 3, 7, 6, 5, 8]
          expect(deep_tree.preorder_traversal {|value| value -= 1 }).to eq(expected_result)
        end
      end

      it "does not return nil values as the result" do
        new_deep_tree = Tree.new([4, 5, 6, 7, 8, 9, 10])
        result = new_deep_tree.preorder_traversal {|value| value -= 1 }
        expect(result.include?(nil)).to eq(false)
      end
    end

    context "when a block is not given" do
      it "returns an error" do
        expect(tree.preorder_traversal).to eq("no block given")
      end
    end
  end

  describe "#postorder_traversal" do
    let(:tree) { described_class.new([1, 2, 3]) }
    let(:deep_tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when a block is given" do
      context "when the root is nil" do
        it "returns nil" do
          empty_tree = Tree.new
          expect(empty_tree.postorder_traversal).to eq(nil)
        end
      end

      it "calls the block" do
        expect { |b| tree.postorder_traversal(&b) }.to yield_control
      end

      it "returns the results of the block with all of the node's values & in the right order" do
        expected_result = [0, 2, 1]
 
        expect(tree.postorder_traversal{|value| value -= 1 }).to eq(expected_result)
      end

      context "when the tree has a deep structure" do
        it "returns the correct result in the correct order" do
          expected_result = [0, 1, 3, 2, 5, 6, 8, 7, 4]
          expect(deep_tree.postorder_traversal {|value| value -= 1 }).to eq(expected_result)
        end
      end
    end

    context "when a block is not given" do
      it "returns an error" do
        expect(tree.postorder_traversal).to eq("no block given")
      end
    end
  end

  describe "#height" do
    let(:tree) { described_class.new([1, 2, 3]) }
    let(:deep_tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when a root does not exist" do
      it "returns nil" do
        empty_tree = Tree.new
        expect(empty_tree.height).to eq(nil)
      end
    end

    context "when a value exists" do
      context "when the tree is deep" do
        it "returns the correct hight" do
          target_node = deep_tree.root.left_children # node with value 3

          expect(deep_tree.height(target_node)).to eq(3)
        end
      end

      context "when the tree is really deep" do
        it "returns the correct hight" do
          very_deep_tree = Tree.new((1..30).to_a)

          target_node = very_deep_tree.find_node(26)
          height_of_target_node = 2

          expect(very_deep_tree.height(target_node)).to eq(height_of_target_node)
        end
      end

      context "when not having a balanced bst" do
        it "returns the correct hight" do
          unbalanced_tree = Tree.new((1..9).to_a)

          unbalanced_tree.insert(10)
          unbalanced_tree.insert(11)
          unbalanced_tree.insert(12)

          target_node = unbalanced_tree.find_node(8)
          height_of_target_node = 5

          expect(unbalanced_tree.height(target_node)).to eq(height_of_target_node)
        end
      end
    end
  end

  describe "#depth" do
    let(:tree) { described_class.new([1, 2, 3]) }
    let(:deep_tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when a root does not exist" do
      it "returns nil" do
        empty_tree = Tree.new
        expect(empty_tree.depth(Node.new)).to eq(nil)
      end
    end

    context "when a given node does not exist" do
      it "returns nil" do
        new_node = Node.new(-1)

        expect(tree.depth(new_node)).to eq(nil)
      end
    end

    context "when a given node exists" do
      it "returns the depth of the node" do
        expected_depth = 1

        expect(deep_tree.depth(deep_tree.find_node(8))).to eq(expected_depth)
      end
    end

    context "when the bst is unbalanced" do
      it "still returns the correct depth" do
        unbalanced_tree = Tree.new((1..9).to_a)

        unbalanced_tree.insert(10)
        unbalanced_tree.insert(11)
        unbalanced_tree.insert(12)

        target_node = unbalanced_tree.find_node(11)
        depth_of_target_node = 4

        expect(unbalanced_tree.depth(target_node)).to eq(depth_of_target_node)
      end
    end

    context "when the searched node is the root" do
      it "returns 0 as the depth" do
        root_node = deep_tree.root
        expect(deep_tree.depth(root_node)).to eq(0)
      end
    end

    context "when the tree has only one node" do
      it "returns 0 for the single node" do
        single_node_tree = Tree.new([1])
        expect(single_node_tree.depth(single_node_tree.root)).to eq(0)
      end
    end
  end

  describe "#balanced?" do
   let(:balanced_tree) { described_class.new([1, 2, 3])}

    context "when the root is nil" do
      invalid_tree = Tree.new
      it "returns an error" do
        expect(invalid_tree.balanced?).to be_nil
      end
    end

    context "when the tree is balanced" do
      it "returns true" do
        expect(balanced_tree.balanced?).to eq(true)
      end

      context "when the tree does not have left nor right children" do
        it "returns true" do
          small_tree = Tree.new([1])

          expect(small_tree.balanced?).to eq(true)
        end
      end
    end

    context "when the tree is not balanced" do
      it "returns false" do
        balanced_tree.insert(1.1)
        balanced_tree.insert(1.2)

        unbalanced_tree = balanced_tree
        
        expect(unbalanced_tree.balanced?).to eq(false)
      end
    end
  end

  describe "rebalance" do
    let(:balanced_tree) { described_class.new([1, 2, 3])}

    context "when the tree is unbalanced" do
      it "rebalances the tree correctly" do
        balanced_tree.insert(1.1)
        balanced_tree.insert(1.2)

        unbalanced_tree = balanced_tree
        unbalanced_tree.balance!

        expect(unbalanced_tree.balanced?).to eq(true)
      end

      it "still contains all values" do
        balanced_tree.insert(1.1)
        balanced_tree.insert(1.2)

        unbalanced_tree = balanced_tree
        values_before = unbalanced_tree.extract_values.sort

        unbalanced_tree.balance!
        values_after = unbalanced_tree.extract_values.sort

        expect(values_before).to eq(values_after)
      end
    end

    context "when rebalancing multiple times" do
      it "remains balanced after multiple rebalance calls" do
        balanced_tree.insert(1.1)
        balanced_tree.insert(1.2)
        balanced_tree.insert(2.5)
        balanced_tree.insert(3.5)
  
        unbalanced_tree = balanced_tree
        unbalanced_tree.balance!
        unbalanced_tree.balance!
  
        expect(unbalanced_tree.balanced?).to eq(true)
      end
    end

    context "when the tree is already balanced" do
      it "changes nothing" do
        structure_before = balanced_tree
        balanced_tree.balance!
  
        expect(structure_before).to eq(balanced_tree)
      end
    end

    context "when the tree is balanced" do
      it "does not change the root when balancing a tree that is already balanced" do
        single_node_tree = Tree.new([1])
        root_before_balance = single_node_tree.root
    
        single_node_tree.balance!
    
        expect(single_node_tree.root).to eq(root_before_balance)
      end
    end
  end
end

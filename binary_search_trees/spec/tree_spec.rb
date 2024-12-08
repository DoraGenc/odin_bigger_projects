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
          searched_value = 2.5
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

          searched_value = 10
          returned_node =  large_tree.find_node(searched_value)
          correct_returned_node_value = 9

          expect(returned_node.value).to eq(correct_returned_node_value)
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
  end

  describe "#node_exists?" do
    let(:tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

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

  describe "#delete" do
    let(:tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9]) }

    context "when the node to delete is the root" do
      it "deletes the root" do
        tree.delete(5)

        expect(tree.root).to eq(nil)
      end
    end

    context "when the node to delete is a leaf" do #hier
      it "deletes the leaf" do
        tree.pretty_print
        tree.delete(1)
        tree.pretty_print
        expect(tree.node_exists?(1)).to eq(false)
      end
    end

    context "when the node to delete has only one child" do
      it "deletes the node" do
        tree.delete(8)

        expect(tree.node_exists?(8)).to eq(false)
      end

      it "does not delete its children" do
        tree.delete(2)

        expect(tree.node_exists?(1)).to eq(true)
      end

      it "links its children to the correct node" do
        tree.pretty_print
        tree.delete(2)
        orphaned_child_value = 1
        tree.pretty_print

        expect(tree.root.left_children.left_children.value).to eq(1)
      end
    end

    context "when the node to delete has 2 children" do
      it "deletes the node" do
        tree.delete(3)

        expect(tree.node_exists?(3)).to eq(false)
      end

      it "does not delete its children" do
        #tree.pretty_print
        tree.delete(3)
        puts ""
        tree.pretty_print

        expect(tree.node_exists?(4)).to eq(true)
        expect(tree.node_exists?(2)).to eq(true)
        expect(tree.node_exists?(1)).to eq(true)
      end
    end
  end
end

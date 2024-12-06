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

  describe "#find" do
    context "when a tree exists" do
      let(:tree) { described_class.new([1, 2, 3, 4, 5, 6, 7, 8, 9])}

      context "when a value exists" do
        xit "returns the node with the value searched for" do
          expect(tree.find(5)).to eq(tree.root)
        end
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
          returned_node =  tree.find_node(searched_value)
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

      context "when adding a node to a leaf node (no children)" do
        xit "adds a child to the right position" do
          new_tree = Tree.new([1, 2, 3])
          new_tree.build_tree
          new_tree.insert(2.5)

          expect(new_tree.root.right_children.right_children.value).to eq(2.5)
        end
      end
    end
  end
end

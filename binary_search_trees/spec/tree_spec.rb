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
  end
end
require_relative '../lib/linked_list.rb'

RSpec.describe LinkedList do

  subject(:linked_list) { described_class.new }

  before do
    allow(linked_list).to receive(:set_head).and_call_original
  end

  describe "#append" do

    context "when calling it" do
      it "creates a new node" do
        allow(Node).to receive(:new).and_call_original
        linked_list.append("value")
        expect(Node).to have_received(:new)
      end

      it "calls #set_head if the list does not contain any elements yet" do
        linked_list.append("value")
        expect(linked_list).to have_received(:set_head)
      end

      it "does not call #set_head again when the list contains something" do
        linked_list.append("value")
        linked_list.append("value")
        expect(linked_list).to have_received(:set_head).once
      end

      it "links the new node to the current last node" do   
        linked_list.append(1)
        linked_list.append(2)
        expect(linked_list.head.next_node.value).to eq(2)
      end
    end
  end

  describe "#prepend" do

    context "when calling it when the list is empty" do
      it "creates a new node" do
        allow(Node).to receive(:new).and_call_original
        linked_list.prepend("value")
        expect(Node).to have_received(:new)
      end

      it "calls #set_head if the list does not contain any elements yet" do
        linked_list.prepend("value")
        expect(linked_list).to have_received(:set_head)
      end

      it "does not call #set_head again when the list contains something" do
        linked_list.prepend("value")
        linked_list.prepend("value")
        expect(linked_list).to have_received(:set_head).once
      end

      it "links the new node to the current last node" do
        linked_list.append(1)
        linked_list.append(2)
        expect(linked_list.head.next_node.value).to eq(2)
      end
    end
  end

  describe "#size" do
    context "when the list contains elements" do
      it "returns the correct total number of nodes in the list" do
        linked_list.append(1)
        linked_list.append(2)
        expect(linked_list.size).to eq(2)
      end
    

      context "when adding a nil value" do
        it "includes nil in the size count" do
          linked_list.append(nil)
          expect(linked_list.size).to eq(1)
        end
      end
    end

    context "when the list is empty" do
      it "returns 0" do
        expect(linked_list.size).to eq(0)
      end
    end
  end

  describe "#tail" do
    context "when the list contains elements" do
      it "returns the correct last element" do
        linked_list.append(1)
        linked_list.append(2)
        expect(linked_list.tail.value).to eq(2)
      end
    end

    context "when the list is empty" do
      it "returns nil" do
        expect(linked_list.tail).to eq(nil)
      end
    end
  end

  describe "#at" do
    context "when the linked list contains a node at the given index" do
      it "returns the node" do
        index = 0
        linked_list.append(1)
        node_value = linked_list.at(index).value
        expect(node_value).to eq(1)
      end
    end

    context "when the linked list contains multiple nodes" do
      it "returns the correct node at the given index" do
        linked_list.append(1)
        linked_list.append(2)
        linked_list.append(3)
        index = 2
        node_value = linked_list.at(index).value
        expect(node_value).to eq(3)  # Should return the value at index 2
      end
    end

    context "when the index is greater than the size of the list" do
      it "returns nil" do
        linked_list.append(1)
        linked_list.append(2)
        index = 5
        node_at_index = linked_list.at(index)
        expect(node_at_index).to eq(nil)
      end
    end

    context "when the linked list does not contain a node at the given index" do
      it "returns nil" do
        index = 0
        node_at_index = linked_list.at(index)
        expect(node_at_index).to eq(nil)
      end
    end

    context "when the linked list is empty" do
      it "returns nil" do
        index = 0
        node_at_index = linked_list.at(index)
        expect(node_at_index).to eq(nil)
      end
    end

    context "when a negative index is provided" do
      it "returns nil" do
        linked_list.append(1)
        node_at_index = linked_list.at(-1)
        expect(node_at_index).to eq(nil)
      end
    end
  end

  describe "#pop!" do

    context "when the list is empty" do
      it "returns nil" do
        expect(linked_list.pop!).to eq(nil)
      end
    end

    context "when the list contains only one element" do
      it "removes the element" do
        linked_list.append(1)
        linked_list.pop!
        expect(linked_list.at(0)).to eq(nil)
      end

      it "returns the removed element" do
        linked_list.append(1)
        expect(linked_list.pop!).to eq(1)
      end
    end

    context "when the linked list contains more than one element" do
      it "removes the last element" do
        linked_list.append(1)
        linked_list.append(2)
        linked_list.pop!
        expect(linked_list.head.next_node).to eq(nil)
      end

      it "returns the removed element" do
        linked_list.append(1)
        linked_list.append(2)
        expect(linked_list.pop!).to eq(2)
      end
    end
  end

  describe "#contains?" do
    context "when the linked list contains only one element" do
      context "when the searched element is included" do
        it "returns true" do
          linked_list.append(1)
          expect(linked_list.contains?(1)).to eq(true)
        end
      end

      context "when the searched element is inluded" do
        it "returns false" do
          linked_list.append(1)
          expect(linked_list.contains?(2)).to eq(false)
        end
      end
    end

    context "when the linked lists contains more than one element" do
      context "when the searched element is included" do

        it "returns true" do
          linked_list.append(1)
          linked_list.append(2)
          expect(linked_list.contains?(2)).to eq(true)
        end
      end

      context "when the element is not included" do
        it "returns false" do
          linked_list.append(1)
          linked_list.append(2)
          expect(linked_list.contains?(3)).to eq(false)
        end
      end
    end
  end

  describe "#find" do
    context "when trying to find an included element" do
      it "returns the index of the node containing the value" do
        linked_list.append(1)
        linked_list.append(2)
        expect(linked_list.find(2)).to eq(1)
      end
    end

    context "when trying to find an excluded element" do
      it "returns nil" do
        linked_list.append(1)
        linked_list.append(2)
        expect(linked_list.find(3)).to eq(nil)
      end
    end

    context "when the list is empty" do
      it "returns nil" do
        expect(linked_list.find(1)).to eq(nil)
      end
    end

    context "when returning the index of an element that has been found" do
      it "starts counting at 0" do
        linked_list.append(1)
        expect(linked_list.find(1)).to eq(0)
      end
    end
  end

  describe "#to_s" do
    context "when printing a linked list in the console" do
      it "prints out the correct values" do
        linked_list.append(1)
        linked_list.append(2)
        expect(linked_list.to_s).to eq("( 1 ) -> ( 2 ) -> nil")
      end

      it "can print out long lists" do
        linked_list.append(1)
        linked_list.append(2)
        linked_list.append(3)
        linked_list.append(4)
        linked_list.append(5)
        linked_list.append(6)
        expect(linked_list.to_s).to eq("( 1 ) -> ( 2 ) -> ( 3 ) -> ( 4 ) -> ( 5 ) -> ( 6 ) -> nil")
      end

      it "prints out nil when the list is empty" do
        expect(linked_list.to_s).to eq(nil)
      end

      it "can print out any value" do
        linked_list.append("hello")
        linked_list.append(",.3$")
        expect(linked_list.to_s).to eq("( hello ) -> ( ,.3$ ) -> nil")
      end
    end
  end

  # Extras
  
  describe "#insert_at" do
    context "when inserting a new node in an already existing list" do
      it "inserts the value at the correct index" do
        linked_list.append(1)
        linked_list.append(2)
        linked_list.append(3)
        linked_list.insert_at(1, "new node") #index 1
        expect(linked_list.to_s).to eq("( 1 ) -> ( new node ) -> ( 2 ) -> ( 3 ) -> nil")
      end

      context "when the chosen index is 0" do
        it "inserts the value at the correct index" do
          linked_list.append(1)
          linked_list.insert_at(0, "new node")
          expect(linked_list.to_s).to eq("( new node ) -> ( 1 ) -> nil")
        end
      end

      context "when the list is empty" do
        it "sets creates a new head with the correct value" do
          linked_list.insert_at(3, "new node")
          expect(linked_list.to_s).to eq("( new node ) -> nil")
        end
      end

      context "when there does not exist something at the chosen index yet" do
        it "returns an error" do
          expect(linked_list.insert_at(3, "new node")).to eq("The index does not exist.")
        end
      end

      context "when the node is nil at the chosen index" do
        it "still works correctly & appends a new node" do
          linked_list.append(1)
          linked_list.append(2)
          linked_list.insert_at(1, "new node")
          expect(linked_list.to_s).to eq("( 1 ) -> ( new node ) -> ( 2 ) -> nil")
        end
      end
    end
  end

  describe "#remove_at" do
    context "when removing an existing element at a valid index" do
      it "removes the element correctly" do
        linked_list.append(1)
        linked_list.append(2)
        linked_list.remove_at(1)
        expect(linked_list.to_s).to eq("( 1 ) -> nil")
      end
    end

    context "when the node to remove is the head" do

      context "when the the list contains one element after the head" do
        it "removes the element correctly" do
          linked_list.append(1)
          linked_list.append(2)
          linked_list.remove_at(0)
          expect(linked_list.head.value).to eq(2)
        end
      end

      context "when the list does not contain an element after the head" do
        it "removes the element correctly" do
          linked_list.append(1)
          linked_list.remove_at(0)
          expect(linked_list.to_s).to eq(nil)
        end
      end
    end

    context "when the list does not contain an element at the given index" do
      it "returns an error" do
        linked_list.append(1)
        expect(linked_list.remove_at(3)).to eq("The index does not exist.")
      end
    end

    context "when the list is empty" do
      it "returns an error" do
        expect(linked_list.remove_at(1)).to eq("The removal failed. The list is empty.")
      end
    end

    context "when the index is invalid" do
      it "returns an error" do
        invalid_index = -2
        expect(linked_list.remove_at(invalid_index)).to eq("The index is invalid. Please only enter integers starting from 0.")
      end
    end
  end
end
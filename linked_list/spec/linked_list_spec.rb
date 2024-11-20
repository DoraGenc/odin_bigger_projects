require_relative '../lib/linked_list.rb'
#require 'rspec'

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
    end

      con
      context "when the searched element is not included" do

    end

    context "when the linked list contains more than one element"
  end
end
require_relative '../lib/bucket.rb'

RSpec.describe Bucket do

  subject(:bucket) { described_class.new }
  let(:node) { instance_double("Node")}

  describe "#set" do

    context "when no key-value pair is set yet" do
      before do
        allow(bucket).to receive(:node).and_return(node)
        allow(Node).to receive(:new).and_call_original
      end

      it "creates a new node" do
        key = "a"
        value = "b"
        bucket.set(key, value)
        expect(Node).to have_received(:new).with(key, value)
      end

      it "creates a new node with correct values" do
        key = "a"
        value = "b"
        bucket.set(key, value)
        expect(bucket.get(key)).to eq(value)
      end
    end

    context "when a key-value pair is already set" do

      it "can link a new node to the head of the list" do
        key1 = "carlos"
        value1 = 1
        bucket.set(key1, value1)

        key2 = "carla"
        value2 = 2
        bucket.set(key2, value2)
        expect(bucket.get(key1)).to eq(value1)
        expect(bucket.get(key2)).to eq(value2)
      end
     
      it "links a new node to the last node" do
        key1 = "carlos"
        value1 = 1
        bucket.set(key1, value1)

        key2 = "carla"
        value2 = 2
        bucket.set(key2, value2)

        key3 = "constantin"
        value3 = 3
        bucket.set(key3, value3)

        expect(bucket.get(key1)).to eq(value1)
        expect(bucket.get(key2)).to eq(value2)
        expect(bucket.get(key3)).to eq(value3)
      end
    end
  end

  
  describe "#get" do
    context "when a key exists" do
      it "returns the value that is assigned to that key" do
        key = "a"
        value = "b"
        bucket.set(key, value)
        expect(bucket.get(key)).to eq(value)
      end
    end

    context "when a key does not exist" do
      it "returns nil" do
        key = "key that has not been set"
        expect(bucket.get(key)).to eq(nil)
      end
    end

    context "when more than one key exists in the bucket" do
      it "returns the value that is assigned to a new key" do
        key1 = "carlos"
        value1 = 1
        bucket.set(key1, value1)

        key2 = "carla"
        value2 = 2
        bucket.set(key2, value2)

        expect(bucket.get(key1)).to eq(value1)
        expect(bucket.get(key2)).to eq(value2)
      end
    end
  end

  describe "#is_head?" do
    context "when a given key is the head" do
      it "returns true" do
        key = "a"
        value = "b"
        bucket.set(key, value)

        expect(bucket.is_head?(key)).to eq(true)
      end
    end

    context "when a given key is not the head" do
      it "returns false" do
        non_existent_key = 1

        expect(bucket.is_head?(non_existent_key)).to eq(false)
      end
    end
  end

  describe "#exists?" do
    context "when a key exists" do
      context "when a key is the head" do
        it "returns true" do
          key = "a"
          value = "b"
          bucket.set(key, value)

          expect(bucket.exists?(key)).to eq(true)
        end
      end
      
      context "when a key is not the head" do
        it "returns true" do
          key1 = "carlos"
          value1 = 1
          bucket.set(key1, value1)

          key2 = "carla"
          value2 = 2
          bucket.set(key2, value2)

          expect(bucket.exists?(key2)).to eq(true)
        end
      end
    end

    context "when a key does not exist" do
      it "returns false" do
        non_existent_key = 1
        expect(bucket.exists?(non_existent_key)).to eq(false)
      end
    end
  end

  describe "#find" do
    context "when a given key exists" do
      context "when the key is the head" do
        it "returns the right index" do
          key = "a"
          value = "b"
          bucket.set(key, value)

          expect(bucket.find(key)).to eq(0)
        end
      end

      context "when a given key is not the head" do
        it "returns the right index" do
          key1 = "carlos"
          value1 = 1
          bucket.set(key1, value1)

          key2 = "carla"
          value2 = 2
          bucket.set(key2, value2)

          expect(bucket.find(key2)).to eq(1)
        end
      end
    end

    context "when a given key does not exist" do
      it "returns nil" do
        non_existent_key = 1
        expect(bucket.find(non_existent_key)).to eq(nil)
      end
    end
  end

  describe "#delete" do
    context "when the given key is the head" do
      it "sets head to nil" do
        key = "a"
        value = "b"
        bucket.set(key, value)
        bucket.delete(key)

        expect(bucket.head?).to eq(false)
      end

      it "returns the deleted value" do
        key = "a"
        value = "b"
        bucket.set(key, value)
        expect(bucket.delete(key)).to eq(value)
      end
    end

    context "when the given key is not the head" do
      it "deletes the key" do
        key1 = "carlos"
        value1 = 1
        bucket.set(key1, value1)

        key2 = "carla"
        value2 = 2
        bucket.set(key2, value2)

        bucket.delete(key2)
        expect(bucket.exists?(key2)).to eq(false)
      end

      it "only deletes the given key" do
        key1 = "carlos"
        value1 = 1
        bucket.set(key1, value1)

        key2 = "carla"
        value2 = 2
        bucket.set(key2, value2)

        bucket.delete(key2)
        expect(bucket.exists?(key1)).to eq(true)
        expect(bucket.exists?(key2)).to eq(false)
      end
    end
  end

  describe "#length" do
    context "when the bucket contains elements" do
      it "counts the nodes in the bucket" do
        key1 = "carlos"
        value1 = 1
        bucket.set(key1, value1)

        key2 = "carla"
        value2 = 2
        bucket.set(key2, value2)

        expect(bucket.length).to eq(2)
      end
    end

    context "when the bucket does not contain elements" do
      it "returns 0" do
        expect(bucket.length).to eq(0)
      end
    end
  end
end
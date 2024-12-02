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
end
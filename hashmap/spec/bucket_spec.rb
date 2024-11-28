require_relative '../lib/bucket.rb'

RSpec.describe Bucket do

  subject(:bucket) { described_class.new }
  let(:node) { instance_double("Node")}

  describe "#set" do

    context "when setting a key-value pair" do
      before do
        allow(bucket).to receive(:node).and_return(node)
        allow(Node).to receive(:new)
      end

      it "creates a new node" do
        key = "a"
        value = "b"
        bucket.set(key, value)
        expect(Node).to have_received(:new).with(key, value)
      end
    end

    context "when setting the first key-value pair" do
      it "creates a new node with correct values" do
        key = "a"
        value = "b"
        bucket.set(key, value)
        expect(bucket.get(key)).to eq(value)
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
  end
end
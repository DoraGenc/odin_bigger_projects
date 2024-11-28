require_relative '../lib/hashmap.rb'

RSpec.describe HashMap do
  subject(:hashmap) { described_class.new }
  let(:bucketmanager) { instance_double("BucketManager") }

  before do
    allow(hashmap).to receive(:bucketmanager).and_return(bucketmanager)
    allow(bucketmanager).to receive(:set)
  end

  describe "#hash" do
    it "takes a key and produces a hash code with it" do
      key = "a"
      expected_hash_code = 97
      expect(hashmap.hash(key)).to eq(97)
    end
  end

  describe "#set" do
    context "when the add_more_buckets? returns false" do
      before do
        allow(hashmap).to receive(:add_more_buckets?).and_return(false)
        allow(hashmap).to receive(:add_more_buckets)
      end

      it "does not call #add_more_buckets" do
        key = "key"
        value = "value"

        hashmap.set(key, value)
        expect(hashmap).not_to have_received(:add_more_buckets)
      end
    end

    context "when the add_more_buckets? returns true" do
      before do
        allow(hashmap).to receive(:add_more_buckets?).and_return(true)
        allow(hashmap).to receive(:add_more_buckets)
      end

      it "does calls #add_more_buckets" do
        key = "key"
        value = "value"

        hashmap.set(key, value)
        expect(hashmap).to have_received(:add_more_buckets)
      end
    end

    context "when adding more buckets" do

      before do
        allow(hashmap).to receive(:capacity).and_return(24)
      end

      it "creates a correct hashcode" do
        key = "key"
        value = "value"

        hashmap.add_more_buckets #24 buckets
        hashmap.set(key, value)
      end
    end

    context "when the bucket is empty" do

      before do
        allow(hashmap).to receive(:add_more_buckets?).and_return(false)
        allow(hashmap).to receive(:add_more_buckets)
      end
    
      it "calls BucketManager to set a value" do
        key = "a"
        value = "b"
        hash_code = 1

        hashmap.set(key, value)
        expect(bucketmanager).to have_received(:set).with(hash_code, key, value)
      end
    end

    context "when the key int he bucket already contains a value" do

      before do
        allow(hashmap).to receive(:add_more_buckets?).and_return(false)
        allow(hashmap).to receive(:add_more_buckets)
      end

      it "still calls BucketManager to update the value" do
        key = "a"
        value1 = "b"
        value2 = "c"

        hashmap.set(key, value1)
        hashmap.set(key, value2)
        expect(bucketmanager).to have_received(:set).twice
      end
    end
  end

  describe "#add_more_buckets?" do
    context "when capacity is less than edge_capacity" do
      before do
        allow(hashmap).to receive(:capacity).and_return(5)
        allow(hashmap).to receive(:edge_capacity).and_return(10)
      end
    
      it "returns false" do
        expect(hashmap.add_more_buckets?).to eq(false)
      end
    end   

    context "when the edge_capacity is reached by the capacity" do
      before do
        allow(hashmap).to receive(:capacity).and_return(12)
        allow(hashmap).to receive(:edge_capacity).and_return(10)
      end

      it "returns true" do
        expect(hashmap.add_more_buckets?).to eq(true)
      end
    end
  end

  describe "#add_more_buckets" do
    context "when the capacity is equal or more than the edge capacity" do
      before do
        allow(hashmap).to receive(:bucketmanager).and_return(bucketmanager)
        allow(bucketmanager).to receive(:add_more_buckets!)
      end

      it "calls add_more_buckets on the bucket manager" do
        hashmap.add_more_buckets
        expect(bucketmanager).to have_received(:add_more_buckets!)
      end
    end
  end
end

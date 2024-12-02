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
        allow(hashmap).to receive(:current_capacity).and_return(13)
        allow(hashmap).to receive(:bucketmanager).and_return(bucketmanager)
        allow(bucketmanager).to receive(:add_more_buckets!)
        allow(bucketmanager).to receive(:set)
      end

      it "creates a correct hashcode" do
        key = "key"
        value = "value"
        expected_hashcode = 23

        hashmap.add_more_buckets #24 buckets
        hashmap.set(key, value)
        expect(bucketmanager).to have_received(:set).with(expected_hashcode, key, value)
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
        allow(hashmap).to receive(:current_capacity).and_return(5)
        allow(hashmap).to receive(:edge_capacity).and_return(10)
      end
    
      it "returns false" do
        expect(hashmap.add_more_buckets?).to eq(false)
      end
    end   

    context "when the edge_capacity is reached by the capacity" do
      before do
        allow(hashmap).to receive(:current_capacity).and_return(12)
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

  describe "#get" do

    context "when the key exists" do
      before do
        allow(hashmap).to receive(:bucketmanager).and_return(bucketmanager)
        allow(bucketmanager).to receive(:get)
      end

      it "calls the bucketmanager" do
        key = "a"
        value = "b"
        hashmap.set(key, value)
        hashmap.get(key)

        expect(bucketmanager).to have_received(:get)
      end
      
      context "when trying to access a key's value" do
        before do
          allow(hashmap).to receive(:bucketmanager).and_call_original
        end

        it "returns the assigned value" do
          key = "a"
          value = "b"
          hashcode = 
          hashmap.set(key, value)
          expect(hashmap.get(key)).to eq(value)
        end
      end
    end

    context "when a key does not exist" do

      before do
        allow(bucketmanager).to receive(:get)
      end

      it "returns nil" do
        non_existent_key = "1"
        expect(hashmap.get(non_existent_key)).to eq(nil)
      end
    end
  end

  describe "#has?" do
    before do
      allow(hashmap).to receive(:bucketmanager).and_call_original
    end

    context "when a key exists" do
      it "returns true" do
        key = "a"
        value = "b"
        hashmap.set(key, value)
        expect(hashmap.has?(key)).to eq(true)
      end
    end

    context "when a key does not exist" do
      it "returns false" do
        non_existent_key = "a"
        expect(hashmap.has?(non_existent_key)).to eq(false)
      end
    end
  end

  describe "#remove" do
    context "when a key exists" do
      context "when a key is the head" do

        before do
          allow(hashmap).to receive(:bucketmanager).and_call_original
        end

        it "removes an entry" do
          key = "a"
          value = "b"
          hashmap.set(key, value)
          hashmap.delete(key)

          expect(hashmap.has?(key)).to eq(false)
        end

        it "returns the deleted value" do
          key = "a"
          value = "b"
          hashmap.set(key, value)
          expect(hashmap.delete(key)).to eq(value)
        end
      end

      context "when a key is not the head" do
        before do
          allow(hashmap).to receive(:bucketmanager).and_call_original
        end

        it "removes an entry" do
          key1 = "carlos"
          value1 = 1
          hashmap.set(key1, value1)

          key2 = "carla"
          value2 = 2
          hash_code2 = 9
          hashmap.set(key2, value2)

          hashmap.delete(key2)
          expect(hashmap.has?(key2)).to eq(false)
        end

        it "returns the deleted value" do
          key1 = "carlos"
          value1 = 1
          hashmap.set(key1, value1)

          key2 = "carla"
          value2 = 2
          hashmap.set(key2, value2)

          expect(hashmap.delete(key2)).to eq(value2)
        end
      end
    end

    context "when a given key does not exist" do
      before do
        allow(bucketmanager).to receive(:delete)
        allow(bucketmanager).to receive(:has?).and_return(false)
      end

      it "returns an error" do
        non_existent_key = "a"

        expect(hashmap.delete(non_existent_key)).to eq("The key does not exist.")
      end
    end

    context "when a given key is nil" do
      before do
        allow(bucketmanager).to receive(:delete)
      end

      it "returns an error" do
        invalid_key = nil

        expect(hashmap.delete(invalid_key)).to eq("The key does not exist.")
      end
    end
  end

  describe "#length" do

    before do
      allow(hashmap).to receive(:bucketmanager).and_call_original
    end

    context "when some entries already exist" do
      before do
        key1 = "carlos"
        value1 = 1
        hashmap.set(key1, value1)

        key2 = "carla"
        value2 = 2
        hash_code2 = 9
        hashmap.set(key2, value2)
      end

      it "returns the correct length" do
        expect(hashmap.length).to eq(2)
      end
    end

    context "when no entries exist" do
      it "returns 0" do
        expect(hashmap.length).to eq(0)
      end
    end
  end
end
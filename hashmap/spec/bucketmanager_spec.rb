require_relative '../lib/bucketmanager'

RSpec.describe BucketManager do

  subject(:bucketmanager) { described_class.new }
  let(:bucket) { instance_double("Bucket") }
  let(:buckets) { Array.new(16) { instance_double("Bucket") } }

  describe "#initialize" do
    before do
      allow(Bucket).to receive(:new)
    end

    context "when a new BucketManager instance is created" do
      it "creates 16 bucket instances" do
        new_bucketmanager = BucketManager.new
        expect(Bucket).to have_received(:new).exactly(16).times
      end
    end
  end

  describe "#set" do
    let(:bucket) { Bucket.new }

    before do
      allow(bucketmanager).to receive(:buckets).and_return([bucket])
    end

    context "when calling #set" do
      it "calls the right bucket" do
        hash_code = 0
        key = "a"
        value = "b"

        bucketmanager.set(hash_code, key, value)
        expect(bucket.get(key)).to eq(value)
      end
    end
  end

  describe "#add_more_buckets!" do
    it "adds 8 more elements to the buckets array" do
      bucketmanager.add_more_buckets!
      expect(bucketmanager.buckets.size).to eq(24)
    end

    context "when calling the real Bucket class" do
      before do
        allow(Bucket).to receive(:new).and_call_original
      end

      it "creates new instances of Bucket as elements" do
        bucketmanager.add_more_buckets!
        expect(bucketmanager.buckets[16].is_a?(Bucket)).to eq(true)
      end
    end
  end

  describe "#current_capacity" do

    context "when no bucket has a key yet" do
      it "returns the correct current capacity" do
        expect(bucketmanager.current_capacity).to eq(0)
      end
    end

    context "when some buckets already have a key" do
      it "returns the correct current capacity" do
        key = "key"
        value = "value" 
        hashcode1 = 0
        hashcode2 = 2

        bucketmanager.set(hashcode1, key, value)
        bucketmanager.set(hashcode2, key, value)
        expect(bucketmanager.current_capacity).to eq(2)
      end
    end
  end

  describe "#get" do
    context "when the given key exists" do
      
    before do
      allow(bucketmanager).to receive(:buckets).and_return([bucket])
      allow(bucket).to receive(:set)
      allow(bucket).to receive(:get)
    end

      it "calls the right bucket" do
        key = "a"
        value = "b"
        hash_code = 0
  
        bucketmanager.set(hash_code, key, value)
        bucketmanager.get(key, hash_code)
  
        expect(bucket).to have_received(:get).with(key)
      end

      context "when accessing a bucket" do
        before do
          allow(bucketmanager).to receive(:buckets).and_call_original
        end

        it "returns the right value" do
          key = "a"
          value = "b"
          hash_code = 0
    
          bucketmanager.set(hash_code, key, value)
          expect(bucketmanager.get(key, hash_code)).to eq(value)
        end
      end
    end

    context "when the given key does not exist" do
      it "returns nil" do
        non_existent_key = 1
        random_hash_code = 0
        expect(bucketmanager.get(non_existent_key, random_hash_code)).to eq(nil)
      end
    end
  end

  describe "#has?" do
    context "when a key exists" do
      it "returns true" do
        key = "a"
        value = "b"
        hash_code = 0
  
        bucketmanager.set(hash_code, key, value)
        expect(bucketmanager.has?(key, hash_code)).to eq(true)
      end
    end

    context "when a key does not exist" do
      it "returns false" do
        non_existent_key = 1
        random_hash_code = 0

        expect(bucketmanager.has?(non_existent_key, random_hash_code)).to eq(false)
      end
    end
  end

  describe "#delete" do
    context "when deleting" do
      before do
        allow(bucketmanager).to receive(:buckets).and_return(buckets)
        allow(buckets).to receive(:[]).with(1).and_return(bucket)
        allow(bucket).to receive(:delete)
      end
  
      it "calls the right bucket" do
        key = "a"
        value = "b"
        hash_code = 1
  
        bucketmanager.delete(key, hash_code)
        expect(bucket).to have_received(:delete).with(key)
      end
    end

    context "when a given key exists" do
      it "deletes the right bucket" do
        key = "a"
        value = "b"
        hash_code = 1

        bucketmanager.set(hash_code, key, value)
        expect(bucketmanager.has?(key, hash_code)).to eq(true)
        bucketmanager.delete(key, hash_code)
        expect(bucketmanager.has?(key, hash_code)).to eq(false)
      end
    end

    context "when a given key does not exist" do
      it "returns an error" do
        non_existent_key = "a"
        random_hash_code = 1

        expect(bucketmanager.delete(non_existent_key, random_hash_code)).to eq("The key does not exist.")
      end
    end

    context "when a given key is nil" do
      it "returns an error" do
        invalid_key = nil
        random_hash_code = 1

        expect(bucketmanager.delete(invalid_key, random_hash_code)).to eq("The key does not exist.")
      end
    end
  end

  describe "#length" do
    context "when some entries already exist" do
      before do
        key1 = "carlos"
        value1 = 1
        hashcode1 = 0
        bucketmanager.set(hashcode1, key1, value1)

        key2 = "carla"
        value2 = 2
        hashcode2 = 1
        bucketmanager.set(hashcode2, key2, value2)
      end

      it "returns the correct length" do
        expect(bucketmanager.length).to eq(2)
      end
    end

    context "when no entries exist" do
      it "returns 0" do
        expect(bucketmanager.length).to eq(0)
      end
    end
  end

  describe "#clear" do
    context "when entries exist already" do
      before do
        key1 = "carlos"
        value1 = 1
        hashcode1 = 0
        bucketmanager.set(hashcode1, key1, value1)

        key2 = "carla"
        value2 = 2
        hashcode2 = 1
        bucketmanager.set(hashcode2, key2, value2)
      end

      it "clears all entries" do
        bucketmanager.clear
        expect(bucketmanager.length).to eq(0)
      end
    end

    context "when no entries exist" do
      it "clears all entries" do
        bucketmanager.clear
        expect(bucketmanager.length).to eq(0)
      end
    end
  end

  describe "#keys" do
    context "when entries exist already" do
      before do
        key1 = "carlos"
        value1 = 1
        hashcode1 = 0
        bucketmanager.set(hashcode1, key1, value1)

        key2 = "carla"
        value2 = 2
        hashcode2 = 1
        bucketmanager.set(hashcode2, key2, value2)
      end
      
      it "returns an array of all keys" do
        key1 = "carlos"
        key2 = "carla"

        expect(bucketmanager.keys).to eq([key1, key2])
      end
    end

    context "when no entries exist yet" do
      it "returns an empty array" do
        expect(bucketmanager.keys).to eq([])
      end
    end
  end
end

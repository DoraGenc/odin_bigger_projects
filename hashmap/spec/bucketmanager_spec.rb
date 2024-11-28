require_relative '../lib/bucketmanager'

RSpec.describe BucketManager do

  subject(:bucketmanager) { described_class.new }

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
    let(:bucket_0) { Bucket.new }

    before do
      allow(bucketmanager).to receive(:buckets).and_return([bucket_0])
    end

    context "when calling #set" do
      xit "calls the right bucket" do
        hash_code = 0
        key = "a"
        value = "b"

        bucketmanager.set(hash_code, key, value)
        expect(bucket_0.key).to eq(key)   
        expect(bucket_0.value).to eq(value)
      end
    end
    
    context "when a key already has a value" do
      xit "overwrites it" do
        hashcode = 0
        key = "key"
        value1 = "value1"
        value2 = "value2"
      
        bucketmanager.set(hashcode, key, value1)
        bucketmanager.set(hashcode, key, value2)
        expect(bucket_0.value).to eq(value2)
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
end

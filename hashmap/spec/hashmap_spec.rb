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
    context "when the bucket is empty" do
      it "calls BucketManager to set a value" do
        key = "a"
        value = "b"
        hash_code = 1

        hashmap.set(key, value)
        expect(bucketmanager).to have_received(:set).with(hash_code, key, value)
      end
    end

    context "when the bucket already contains a value" do
      it "still calls BucketManager" do
        key = "a"
        value1 = "b"
        value2 = "c"

        hashmap.set(key, value1)
        hashmap.set(key, value2)
        expect(bucketmanager).to have_received(:set).twice
      end
    end
  end
end

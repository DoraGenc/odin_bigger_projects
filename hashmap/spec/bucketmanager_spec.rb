require_relative '../lib/bucketmanager'

RSpec.describe BucketManager do

  subject(:bucketmanager) { described_class.new }

  before do
    allow(Bucket).to receive(:new)
  end

  describe "#initialize" do
    context "when a new BucketManager instance is created" do
      it "creates 16 bucket instances" do
        new_bucketmanager = BucketManager.new
        expect(Bucket).to have_received(:new).exactly(16).times
      end
    end
  end

  describe "#set" do
    let(:buckets) { Array.new(16) { instance_double("Bucket") } }

    before do
      allow(bucketmanager).to receive(:buckets).and_return(buckets)
      allow(buckets[1]).to receive(:set)
    end

    context "when calling #set" do
      it "calls the right bucket" do
        hash_code = 1
        key = "a"
        value = "b"

        bucketmanager.set(hash_code, key, value)
        expect(buckets[1]).to have_received(:set).with(key, value)
      end
    end
  end
end
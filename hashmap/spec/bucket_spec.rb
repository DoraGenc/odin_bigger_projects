require_relative '../lib/bucket.rb'

RSpec.describe Bucket do

  subject(:bucket) { described_class.new }

  describe "#set" do
    it "changes the key and value" do
      key = "a"
      value = "b"
      bucket.set(key, value)
      expect(bucket.key).not_to be_nil
      expect(bucket.value).not_to be_nil
    end
  end
end
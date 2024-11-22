require_relative '../lib/hashmap.rb'

RSpec.describe HashMap do
  subject(:hashmap) { described_class.new }

  describe "#hash" do
    it "takes a key and produces a hash code with it" do
      key = "a"
      expected_hash_code = 97
      expect(hashmap.hash(key)).to eq(97)
    end
  end
end
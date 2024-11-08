require_relative '../lib/node.rb'

RSpec.describe Node do

  subject(:node) { described_class.new }

  context "when creating a new node object" do
    it "sets value to nil if no element is provided" do
      expect(node.value).to eq(nil)
    end

    it "sets next_node to nil" do
      expect(node.next_node).to eq(nil)
    end
  end
end
require_relative "../lib/node.rb"

RSpec.describe Node do
  let(:node) { described_class.new }

  describe "#initialize" do
    context 'when creating a new node object' do
      it 'sets left_children to nil if no element is provided' do
        expect(node.left_children).to eq(nil)
      end

      it 'sets right_children to nil if no element is provided' do
        expect(node.right_children).to eq(nil)
      end

      it 'sets value to nil' do
        expect(node.value).to eq(nil)
      end
    end
  end
end

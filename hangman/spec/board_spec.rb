require_relative '../lib/board.rb'

RSpec.describe Board do

  let(:board) { described_class.new }
  let(:wordpicker) { instance_double(Wordpicker) }

  describe "#create_secret_word" do
    context "when calling create_secret_word" do

      before do
        allow(Wordpicker).to receive(:new).and_return(wordpicker)
        allow(wordpicker).to receive(:pick_word)
      end

      it "creates a new instance of Wordpicker" do
        board.create_secret_word
        expect(Wordpicker).to have_received(:new)
      end

      it "calls #pick_word on the wordpicker" do
      board.create_secret_word
      expect(wordpicker).to have_received(:pick_word)
      end
    end
  end
end
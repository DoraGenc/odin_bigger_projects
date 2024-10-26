require_relative '../lib/board.rb'

RSpec.describe Board do

  let(:board) { described_class.new }
  let(:wordpicker) { instance_double(Wordpicker) }

  describe "#create_secret_word" do
    context "when calling create_secret_word" do

      before do
        allow(Wordpicker).to receive(:new).and_return(wordpicker)
        allow(wordpicker).to receive(:pick_word)
        allow(board).to receive(:update_board!)
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

  describe "#correct_guess" do

    before do
      allow(board).to receive(:update_board!)
    end
    
    context "when the player guesses a correct letter" do

      it "calls #update_board! with the correct index" do
        board.instance_variable_set(:@secret_word, ["t", "e", "s", "t"])
        board.correct_guess("t")
        expect(board).to have_received(:update_board!).with(0)
      end
    end
  end
end
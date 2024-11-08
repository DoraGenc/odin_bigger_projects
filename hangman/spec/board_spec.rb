require_relative '../lib/board.rb'

RSpec.describe Board do

  let(:board) { described_class.new }
  let(:wordpicker) { instance_double(Wordpicker) }

  describe "#setup_secret_word" do
    context "when calling setup_secret_word" do

      before do
        allow(Wordpicker).to receive(:new).and_return(wordpicker)
        allow(wordpicker).to receive(:pick_word).and_return("a")
        allow(board).to receive(:update_board!)
        allow(board).to receive(:set_secret_word!).and_call_original
        allow(board).to receive(:initialize_current_state).and_call_original
      end

      it "creates a new instance of Wordpicker" do
        board.setup_secret_word
        expect(Wordpicker).to have_received(:new)
      end

      it "calls #pick_word on the wordpicker" do
        board.setup_secret_word
        expect(wordpicker).to have_received(:pick_word)
      end
    
      it "calls set_secret_word with the correct argument" do
        board.setup_secret_word
        expect(board).to have_received(:set_secret_word!).with("a")
      end

      it "initializes the current state correctly" do
        board.setup_secret_word
        expect(board.what_is_current_state).to eq("_")
      end
    end
  end

  describe "#compare_guess" do

    before do
      allow(board).to receive(:update_board!)
    end

    context "when comparing a guess with the secret word" do
      context "when index returns nil" do
        
        before do
          allow(board).to receive(:find_index).and_return nil
        end

        it "does not call #update_board!" do
          expect(board).not_to have_received(:update_board!)
        end
      end

      context "when index does not return nil" do
        before do
          allow(board).to receive(:find_index).and_return 1
        end

        it "calls #update_board when a guessed letter is included" do
        board.instance_variable_set(:@secret_word, ["a"])
          guess = "a"
          board.compare_guess(guess)
          expect(board).to have_received(:update_board!)
        end 
      end
    end
  end

  describe "#compare_guess" do

    before do
      allow(board).to receive(:update_board!).and_call_original
    end

    context "when the player guesses a correct letter" do

      before do
        board.instance_variable_set(:@secret_word, ["t"])
        board.instance_variable_set(:@current_state, ["_"])
      end

      it "calls #update_board! with the correct index" do
        board.compare_guess("t")
        expect(board).to have_received(:update_board!).with(0)
      end

      it "updates current_state" do
        board.compare_guess("t")
        expect(board.what_is_current_state).to eq("t") 
      end
    end

    context "when the player guessed an incorrect letter" do

      it "does not call #update_board!" do
        board.instance_variable_set(:@secret_word, ["a"])
        board.compare_guess("t")
        expect(board).not_to have_received(:update_board!)
      end
    end
  end

  describe "#win?" do
    context "when the current_state equals the secret_word" do

      before do
        allow(Wordpicker).to receive(:new).and_return(wordpicker)
        allow(wordpicker).to receive(:pick_word).and_return("a")
        allow(board).to receive(:set_secret_word!).and_call_original
        allow(board).to receive(:initialize_current_state).and_call_original
      end

      it "returns true" do
        board.compare_guess("a")
        board.setup_secret_word
        expect(board.win?).to eq(true)
      end
    end
  end
end
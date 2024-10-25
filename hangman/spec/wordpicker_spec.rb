require_relative '../lib/wordpicker.rb'

RSpec.describe Wordpicker do

  let(:wordpicker) { described_class.new }

  before do 
    allow(wordpicker).to receive(:rand).and_return(0)
    allow(File).to receive(:readlines).and_return("cherry")
    allow(File).to receive(:chomp)
  end

  describe "#pick_word" do
    context "when calling pick_word" do
      
      it "calls #readlines on the right File" do
        file_path = '../lib/google-10000-english-no-swears.txt'
        wordpicker.pick_word
        expect(File).to have_received(:readlines).with(file_path)
      end
    end
  end
end
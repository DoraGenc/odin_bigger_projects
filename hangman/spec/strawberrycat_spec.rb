require_relative "../lib/strawberrycat"


RSpec.describe StrawberryCat do

  subject(:cat) { described_class.new }

  describe "#change_mood" do
    context "when the argument is positive" do
      
      it "increases the cat's mood" do
        cat.change_mood(1)
        expect(cat.mood).to eq(1)
      end
    end

    context "when the argument is negative" do

      it "decreases the cat's mood" do
        cat.change_mood(-1)
        expect(cat.mood).to eq(-1)
      end
    end

    context "when the mood after calling mood_change is 3 or above" do
      
      it "sets the mood to 3" do
        cat.change_mood(4)
        expect(cat.mood).to eq(3)
      end

      it "can decrease the mood again when it is eqal to 3" do
        cat.change_mood(4)
        cat.change_mood(-4)
        expect(cat.mood).to eq(-1)
      end
    end

    context "when the mood after calling mood_change is -3 or below" do

      it "sets the mood to -3" do
        cat.change_mood(-4)
        expect(cat.mood).to eq(-3)
      end

      it "can decrease the mood again when it is equal to -3" do
        cat.change_mood(-4)
        cat.change_mood(4)
        expect(cat.mood).to eq(1)
      end
    end
  end

end
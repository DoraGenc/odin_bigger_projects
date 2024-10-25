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

    context "when the argument is a float" do

      it "is converted to an integer" do
        cat.change_mood(1.2)
        expect(cat.mood).to eq(1)
      end
    end
  end

  describe "#meow" do
    context "when the cat's mood is below 0" do
      it "prints an angry meow" do
        cat.change_mood(-1)
        expect { cat.meow }.to output("\n[\e[0;31;49mLord of Mischief\e[0m] \"Strawberry Cat\": meoww :<").to_stdout
      end
    end

    context "when the cat's mood is happy" do
      it "prints a happy meow" do
        cat.change_mood(2)
        expect { cat.meow }.to output("\n[\e[0;31;49mLord of Mischief\e[0m] \"Strawberry Cat\": meowwww.. :3").to_stdout
      end
    end

    context "when the cat's mood is neutral" do
      it "prints a neutral meow" do
        expect { cat.meow }.to output("\n[\e[0;31;49mLord of Mischief\e[0m] \"Strawberry Cat\": purr... :3").to_stdout
      end
    end
  end

  describe "#take_damage" do
    context "when taking damage" do
      it "looses exactly 1 hp" do
        cat.take_damage!
        expect(cat.hp).to eq(6)
      end

      it "looses one mood point" do
        cat.take_damage!
        expect(cat.mood).to eq(-1)
      end
    end
  end

  describe "#print_cat" do

    before do
      allow(cat).to receive(:print_pieces)
      allow(cat).to receive(:print_cat).and_call_original
    end

    context "when calling print_cat before taking damage" do
      it "prints the whole cat" do
        cat.print_cat
        expect(cat).to have_received(:print_pieces).with(1)
      end
    end

    context "when calling print_cat after taking damage" do
      it "does not print the whole cat" do
        cat.take_damage!
        cat.print_cat
        expect(cat).to have_received(:print_pieces).with(2)
      end
    end
  end
end
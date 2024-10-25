require_relative '../lib/player.rb'

RSpec.describe Player do

  let(:name) { "player1" }
  subject(:player) { described_class.new(name)}

  context "when initializing a Player instance" do
    it "has a name" do
      expect(player.name).to eql(name)
    end
  end

  context "when trying to change the name afterwards" do

    it "the name can not be changed" do
      new_name = "player two"
      expect { player.mark_type = new_name }.to raise_error(NoMethodError)
    end
  end
end
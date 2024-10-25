require_relative '../lib/game.rb'

RSpec.describe Game do

  let(:player1) { double("Player1", name: "player one", mark_type: "X")}
  let(:player2) { double("Player2", name: "player two", mark_type: "O")}
  subject(:game) { described_class.new(player1, player2) }

  let(:fake_board) { double("Board") }

  describe '#play_game' do
    describe "until win?" do
      before do
        allow(game).to receive(:win?).and_return(false, true)
        allow(game).to receive(:check_and_choose_field)
        allow(game).to receive(:switch_players!)
        allow(game).to receive(:turn_counter).and_return(0)
        allow(game).to receive(:announce_result)
        allow(game).to receive(:board).and_return(fake_board)
        allow(fake_board).to receive(:print_board)
      end
    
      context "when play_game is called" do

        it "calls check_and_choose_field" do
          game.play_game
          expect(game).to have_received(:check_and_choose_field)
        end

        it "calls turn_counter twice for each loop" do
          game.play_game
          expect(game).to have_received(:turn_counter).twice #einmal bei until und einmal hochzählen
        end

        it "calls switch_players! once for each loop" do
          game.play_game
          expect(game).to have_received(:switch_players!).once
        end

        it "calls print_board twice for each loop" do
          game.play_game
          expect(fake_board).to have_received(:print_board).twice
        end
      end
    end

    describe "unless win?" do
    
      describe "when win? returns false" do
        before do
          allow(game).to receive(:check_and_choose_field)
          allow(game).to receive(:switch_players!)
          allow(game).to receive(:turn_counter).and_return(0)
          allow(game).to receive(:announce_result)
          allow(game).to receive(:board).and_return(fake_board)
          allow(fake_board).to receive(:print_board)
          allow(game).to receive(:puts)
          allow(game).to receive(:win?).and_return(false)
        end

        context "when checking win?" do
          it "calls puts once to announce switched turns" do
            game.play_game
            expect(game).to have_received(:puts).once
          end
        end
      end

      describe "when win? returns true" do
        before do
          allow(game).to receive(:check_and_choose_field)
          allow(game).to receive(:switch_players!)
          allow(game).to receive(:turn_counter).and_return(0)
          allow(game).to receive(:announce_result)
          allow(game).to receive(:board).and_return(fake_board)
          allow(fake_board).to receive(:print_board)
          allow(game).to receive(:puts)
          allow(game).to receive(:win?).and_return(true)
        end

        context "when checking win?" do
          it "does not call puts to announce switched turns" do
            game.play_game
            expect(game).not_to have_received(:puts)
          end

          it "calls announce result" do
            game.play_game
            expect(game).to have_received(:announce_result)
          end
        end
      end

      describe "when the turn_counter above 9" do

        before do
          allow(game).to receive(:check_and_choose_field)
          allow(game).to receive(:switch_players!)
          allow(game).to receive(:turn_counter).and_return(10)
          allow(game).to receive(:announce_result)
          allow(game).to receive(:board).and_return(fake_board)
          allow(fake_board).to receive(:print_board)
          allow(game).to receive(:puts)
          allow(game).to receive(:win?).and_return(false)
        end

        context "when checking the turn_counter" do

          it "breaks the loop and calls announce_result" do
            game.play_game
            expect(game).to have_received(:announce_result)
          end

          it "breaks the loop which means that it does not call check_and_choose_field e.g." do
            game.play_game
            expect(game).not_to have_received(:check_and_choose_field)
          end
        end
      end
    end
  end
end

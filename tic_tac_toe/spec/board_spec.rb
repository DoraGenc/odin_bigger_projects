require_relative '../lib/board.rb'

RSpec.describe Board do

  subject(:board) { described_class.new }
  
  let(:INITIAL_BOARD) { [
    ["1", "2", "3"],
    ["4", "5", "6"],
    ["7", "8", "9"]
  ] }

  describe "#initialize" do
    context "when a new Board instance is created" do

      it "current_board equals INITIAL_BOARD" do
        expect(board.current_board).to eql(INITIAL_BOARD)
      end
    end
  end

  describe "#print_board" do
    context "when no player chose where to put a mark yet" do
      it "prints the INITIAL BOARD" do
      
        expected_output = "1 | 2 | 3\n--+---+--\n4 | 5 | 6\n--+---+--\n7 | 8 | 9\n"
        expect { board.print_board }.to output(expected_output).to_stdout
      end
    end
  end

  describe "#update_board" do
    context "when calling update_board with a chosen field number and a mark type" do

      let(:chosen_field) {"2"}
      let(:mark_type) {"O"}


      it "updates the board on the correct field" do

        board.update_board!(chosen_field, mark_type)
        expect(board.current_board[0][1]).to eq(mark_type)
      end

      it "does not change the board if the chosen field does not exist" do
        
        invalid_field = "11"

        board.update_board!(invalid_field, mark_type)
        expect(board.current_board).to eq(INITIAL_BOARD)
      end
      
      it "does not accept integers as the chosen_field" do

        invalid_field = 1

        board.update_board!(invalid_field, mark_type)
        expect(board.current_board).to eq(INITIAL_BOARD)
      end

      it "also accepts single integers as the mark_type" do

        mark_type = 0
        expected_board = [
          ["1", 0, "3"],
          ["4", "5", "6"],
          ["7", "8", "9"]
        ]

        board.update_board!(chosen_field, mark_type)
        expect(board.current_board).to eq(expected_board)
      end

      it "also accepts longer integers as the mark_type" do

        mark_type = 0233222
        expected_board = [
          ["1", 0233222, "3"],
          ["4", "5", "6"],
          ["7", "8", "9"]
        ]

        board.update_board!(chosen_field, mark_type)
        expect(board.current_board).to eq(expected_board)
      end

      it "also accepts longer strings as the mark_type" do

        mark_type = "alge"
        expected_board = [
          ["1", "alge", "3"],
          ["4", "5", "6"],
          ["7", "8", "9"]
        ]

        board.update_board!(chosen_field, mark_type)
        expect(board.current_board).to eq(expected_board)
      end

      it "accepts any string as the mark_type" do
        
        mark_type = "§$§5"
        expected_board = [
          ["1", "§$§5", "3"],
          ["4", "5", "6"],
          ["7", "8", "9"]
        ]

        board.update_board!(chosen_field, mark_type)
        expect(board.current_board).to eq(expected_board)
      end

      it "can not change the value of a field after creating an instance" do
        initial_mark_type = "P1"
        new_mark_type = "P2"

        board.update_board!(chosen_field, initial_mark_type)
        board.update_board!(chosen_field, new_mark_type)

        expect(board.current_board[0][1]).to eql(initial_mark_type)  
      end
    end
  end
end

# 2 mal das Selbe Feld
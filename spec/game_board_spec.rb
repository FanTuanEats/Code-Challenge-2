require_relative "../src/game_board"

RSpec.describe GameBoard, type: :model do
  it { should validate_presence_of(:number_of_columns) }
  it { should validate_presence_of(:number_of_rows) }
  context "#initialize" do
    it "builds the grid from number_of_columns and number_of_rows" do
      board = GameBoard.new(number_of_columns: 4, number_of_rows: 3)
      expect(board.grid).to eq([[nil, nil, nil, nil],[nil, nil, nil, nil],[nil, nil, nil,nil]])
    end
  end

  context "#empty_row_in_column?" do
    it "returns true if a column is nil for at least one row" do
      board = GameBoard.new(number_of_columns: 3, number_of_rows: 3)
      board.grid = ([["Player", nil, nil],["Player", nil, nil],[nil, nil, nil]])

      expect(board.empty_row_in_column?(0)).to be true
    end

    it "returns false if a column is filled in every column" do
      board = GameBoard.new(number_of_columns: 3, number_of_rows: 3)
      board.grid = ([["Player", nil, nil],["Player", nil, nil],["Player", nil, nil]])

      expect(board.empty_row_in_column?(0)).to be false
    end
  end

  context "#drop_gamepiece" do
    it "fills the bottom-most column" do
      board = GameBoard.new(number_of_columns: 3, number_of_rows: 3)

      board.drop_gamepiece(0, "Player")
      expect(board.grid).to eq([[nil, nil, nil],[nil, nil, nil],["Player", nil, nil]])

      board.drop_gamepiece(0, "Player")
      expect(board.grid).to eq([[nil, nil, nil],["Player", nil, nil],["Player", nil, nil]])
    end

    it "raises an error if column is already full" do
      board = GameBoard.new(number_of_columns: 3, number_of_rows: 3)
      board.grid = ([["Player", nil, nil],["Player", nil, nil],["Player", nil, nil]])
      expect { board.drop_gamepiece(0, "Player") }.to raise_error(ColumnFullError)
    end
  end
end

require "active_model"
require_relative "player"

class ComputerPlayer < Player
  include ActiveModel::Validations
  attr_accessor :strategy_id, :strategy

  validates :strategy_id, presence: true, inclusion: { in: (1..2) }

  def initialize(name: "Conan the AI Destroyer", strategy_id: nil)
    super
    @strategy = set_strategy(strategy_id)
  end

  def play_turn(board)
    column = choose_column(board)
    play_gamepiece(column)
  end

  def choose_column(board)
    if strategy == "Random walk"
      identify_rows_with_pieces
      identify_columns_with_pieces
    elsif strategy == "Min-max"
    end
  end

  def set_strategy(strategy_id)
    case strategy_id
    when 1 then "Random walk"
    when 2 then "Min-max"
    end
  end

  private

  attr_accessor :columns_with_pieces, :rows_with_pieces

  def identify_columns_with_pieces
    @columns_with_pieces = []
    board.grid.transpose.each_with_index do |column, index|
      columns_with_pieces << column if column.include?(token)
    end
  end

  def identify_rows_with_pieces
    @rows_with_pieces = []
    board.grid.each_with_index do |row, index|
      rows_with_pieces << row if row.include?(token)
    end
  end
end

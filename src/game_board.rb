require "active_model"
require_relative "column_full_error"

class GameBoard
  include ActiveModel::Validations
  ACCEPTABLE_DIMENSIONS = (3..10)
  attr_accessor :grid, :number_of_columns, :number_of_rows

  validates :grid, presence: true
  validates :number_of_columns, presence: true
  validates :number_of_rows, presence: true

  def initialize(number_of_columns: nil, number_of_rows: nil)
    @number_of_columns = number_of_columns
    @number_of_rows = number_of_rows
    @grid = build_grid(number_of_columns, number_of_rows)
  end

  def drop_gamepiece(column, player)
    validate_space_in_column(column)
    mark_first_empty_row_for(column, player)
  end

  def empty_row_in_column?(column)
    grid.each do |row|
      return true if row[column].nil?
    end
    false
  end

  private

  def build_grid(columns, rows)
    grid = []
    rows&.times do
      grid << Array.new(columns)
    end
    grid
  end

  def mark_first_empty_row_for(column, player)
    reversed_grid = grid.reverse
    reversed_grid.each_with_index do |row, index|
      return reversed_grid[index][column] = player if row[column].nil?
    end
    grid = reversed_grid.reverse
  end

  def validate_space_in_column(column)
    raise ColumnFullError unless empty_row_in_column?(column)
  end
end

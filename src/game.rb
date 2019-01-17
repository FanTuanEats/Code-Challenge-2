require "forwardable"
require_relative "game_board"
require_relative "computer_player"
require_relative "human_player"
require_relative "system_output"
require_relative "validations"

class Game
  extend Forwardable
  include Validations
  include SystemOutput

  attr_reader :board, :number_of_columns
  def_delegators :board, :drop_gamepiece, :validate_space_in_column

  def initialize
    @players = []
  end

  def run
    set_game_dimensions
    set_winning_condition
    set_players
    begin_the_game!
  end

  private

  attr_accessor :players
  attr_reader :number_of_columns, :number_of_rows

  def greatest_dimension
    [number_of_columns, number_of_rows].max
  end

  def set_game_dimensions
    set_column_dimension
    set_row_dimension
    @board = GameBoard.new(number_of_columns: number_of_columns, number_of_rows: number_of_rows)
  end

  def set_winning_condition
    ask_for_number_of_winning_series_length
    begin
      input = gets.chomp.to_i
      validate_numerical_input(input, (3..greatest_dimension))
      @winning_length = input
    rescue UserInputError => e
      puts e.message
      set_winning_condition
    end
  end

  def set_row_dimension
    ask_for_number_of_rows
    begin
      input = gets.chomp.to_i
      validate_numerical_input(input, GameBoard::ACCEPTABLE_DIMENSIONS)
      @number_of_rows = input
    rescue UserInputError => e
      puts e.message
      set_row_dimension
    end
  end

  def set_column_dimension
    ask_for_number_of_columns
    begin
      input = gets.chomp.to_i
      validate_numerical_input(input, GameBoard::ACCEPTABLE_DIMENSIONS)
      @number_of_columns = input
    rescue UserInputError => e
      puts e.message
      set_column_dimension
    end
  end

  def begin_the_game!
    players.each do |player|
      print_grid
      player.play_turn
      return congratulatory_message(player) if won?(player)
    end
  end

  def set_ai_player
    ask_for_ai_strategy
    begin
      strategy_id = gets.chomp.to_i
      validate_numerical_input(strategy_id, (1..2))
      players << ComputerPlayer.new(strategy_id: strategy_id)
    rescue UserInputError => e
      puts e.message
      set_ai_player
    end
  end

  def set_players
    ask_for_player_name
    players << HumanPlayer.new(name: gets.chomp)
    set_ai_player
  end
end

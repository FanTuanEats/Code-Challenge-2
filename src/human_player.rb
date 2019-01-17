class HumanPlayer < Player
  def play_turn(board)
    ask_for_a_column
    begin
      column = gets.chomp.to_i
      validate_numerical_input(input: column, range: (1..number_of_columns))
      play_gamepiece(column)
    rescue UserInputError => e
      puts e.message
      play_turn
    end
  end
end

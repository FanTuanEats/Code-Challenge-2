module SystemOutput
  def ask_for_a_column
    puts "Choose a column (1 through #{number_of_columns}, from left to right) to drop your token."
  end

  def ask_for_ai_strategy
    puts "Which AI strategy do you want to play against? Choose 1 for Random Walk, or 2 for Min-Max."
  end

  def ask_for_number_of_columns
    puts "Choose a number of columns (from 3 to 10) for the grid."
  end

  def ask_for_number_of_rows
    puts "Choose the number of rows (from 3 to 10) for the grid."
  end

  def ask_for_number_of_winning_series_length
    puts "How many tokens need to be adjacent to win? (What's the winning length of consecutive tokens, in a row, in a column or diagonally?)"
  end

  def ask_for_player_name
    puts "What shall we call you?"
  end

  def print_congratulatory_message(player)
    puts "Congratulations, #{player.name} — victory is yours."
  end

  def print_grid
    system "clear"
    puts "\n"
    print_game_title
    puts "\n"
    print_game_grid
    puts "\n"
  end

  private

  def print_game_title
    puts "  #############################"
    puts "  #                           #"
    puts "  #     LIFE IS AWESOME:      #"
    puts "  #     CONNECT SOME STUFF    #"
    puts "  #                           #"
    puts "  #############################"
  end

  def print_game_grid
    print_header
    print_rows
  end

  def print_header
    header = "|"
    number_of_columns.times do |i|
      i += 1
      header << " #{i} "
      header << "|"
    end
    header << add_separator(header.length)
    puts header
  end

  def add_separator(length)
    separator = "\n"
    length.times do
      separator << "—"
    end
    separator
  end

  def print_rows
    formatted_rows = ""
    board.grid.each_with_index do |row, index|
      formatted_row = index > 0 ? "\n| " : "| "
      formatted_row << row.map { |e| e.nil? ? " " : e }.join(" | ")
      formatted_row << " |"
      formatted_rows << formatted_row
      formatted_rows << add_separator(formatted_row.length)
    end
    puts formatted_rows
  end
end

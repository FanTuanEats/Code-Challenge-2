require 'pry'

require_relative "tic_tac_toe/version"
require_relative "tic_tac_toe/game"
require_relative "tic_tac_toe/board"
require_relative "tic_tac_toe/player"
require_relative "tic_tac_toe/human_player"
require_relative "tic_tac_toe/computer_player"

puts "\n######################"
puts "Let's play Tic Tac Toe"
puts "######################\n"

strategy = nil
strategies = TicTacToe::ComputerPlayer::STRATEGIES.keys

loop do
	puts "\n[GAME] Select AI strategy (ex. 1):\n\n  [1] Random\n  [2] MiniMax"
	print "\nStrategy: "
	break if strategies.include?(strategy = gets.chomp.to_i)
end

computer = TicTacToe::ComputerPlayer.new(TicTacToe::Game::SYMBOLS[0], 'Computer')
human = TicTacToe::HumanPlayer.new(TicTacToe::Game::SYMBOLS[1], 'You')
players = [human, computer]

TicTacToe::Game.new(strategy, players).play

require 'spec_helper'
require_relative '../../lib/tic_tac_toe/player'
require_relative '../../lib/tic_tac_toe/computer_player'
require_relative '../../lib/tic_tac_toe/board'

RSpec.describe TicTacToe::ComputerPlayer do
	let(:symbol) { 'X' }
	let(:name) { 'Computer' }
	let(:player) { described_class.new(symbol, name) }
	let(:board) { TicTacToe::Board.new(4, 4) }

	include_examples "behaves like a player", 'X', 'Computer'

	ignore_puts

	it 'should be able to play the game with random strategy' do
		game = double({ strategy: 'random', board: board })
		expect(player.play(game)).to eq symbol
	end

	it 'should be able to play the game with minimax strategy' do
		some_slot = 12
		game = double({ strategy: 'mini_max', board: board })
		allow(player).to receive(:mini_max).and_return(some_slot)
		expect(player.play(game)).to eq symbol
	end
end

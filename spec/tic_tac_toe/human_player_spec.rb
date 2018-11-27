require 'spec_helper'
require_relative '../../lib/tic_tac_toe/player'
require_relative '../../lib/tic_tac_toe/human_player'
require_relative '../../lib/tic_tac_toe/board'

RSpec.describe TicTacToe::HumanPlayer do
	let(:symbol) { 'O' }
	let(:name) { 'You' }
	let(:player) { described_class.new(symbol, name) }
	let(:board) { TicTacToe::Board.new(4, 4) }

	include_examples "behaves like a player", 'O', 'You'

	ignore_puts

	it 'should be able to play the game' do
		slot = 12
		game = double({ board: board })
		allow(player).to receive(:get_slot_input).and_return(slot)
		expect(player.play(game)).to eq symbol
	end
end

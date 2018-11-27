require 'spec_helper'
require_relative '../../lib/tic_tac_toe/game'
require_relative '../../lib/tic_tac_toe/player'
require_relative '../../lib/tic_tac_toe/computer_player'
require_relative '../../lib/tic_tac_toe/board'

RSpec.describe TicTacToe::Game do
	let(:human_player) { TicTacToe::HumanPlayer.new(TicTacToe::Game::SYMBOLS[1], 'You') }
	let(:computer_player) { TicTacToe::ComputerPlayer.new(TicTacToe::Game::SYMBOLS[0], 'Computer') }
	let(:players) { [human_player, computer_player] }
	let(:board) { TicTacToe::Board.new(4, 4) }

	ignore_puts

	describe 'initializing' do
		let(:game) { described_class.new(1, players) }

		it { expect(game).to be_an_instance_of(described_class) }

		it 'should select current_player as the first of the array of players' do
			expect(game.current_player).to eq(players[0])
		end

		it 'should be able to select the human_player' do
			expect(game.human_player).to eq(human_player)
		end
	end

	context 'winning combinations' do
		it 'same 3 consecutive symbols horizontally' do
			board.slots[6] = human_player.symbol
			board.slots[7] = human_player.symbol
			board.slots[8] = human_player.symbol

			game = described_class.new(1, players, board.slots)
			game.play
			expect(game.winner).to eq(human_player)
		end

		it 'same 3 consecutive symbols vertically' do
			board.slots[2] = human_player.symbol
			board.slots[6] = human_player.symbol
			board.slots[10] = human_player.symbol

			game = described_class.new(1, players, board.slots)
			game.play
			expect(game.winner).to eq(human_player)
		end

		it 'same 3 consecutive symbols diagonally' do
			board.slots[6] = human_player.symbol
			board.slots[11] = human_player.symbol
			board.slots[16] = human_player.symbol

			game = described_class.new(1, players, board.slots)
			game.play
			expect(game.winner).to eq(human_player)
		end
	end

	it 'should be a draw if no winner is found' do
		board.slots[1] = human_player.symbol
		board.slots[3] = human_player.symbol
		board.slots[6] = human_player.symbol
		board.slots[8] = human_player.symbol
		board.slots[10] = human_player.symbol
		board.slots[12] = human_player.symbol
		board.slots[13] = human_player.symbol
		board.slots[15] = human_player.symbol
		board.slots[2] = computer_player.symbol
		board.slots[4] = computer_player.symbol
		board.slots[5] = computer_player.symbol
		board.slots[7] = computer_player.symbol
		board.slots[9] = computer_player.symbol
		board.slots[11] = computer_player.symbol
		board.slots[14] = computer_player.symbol
		board.slots[16] = computer_player.symbol

		game = described_class.new(1, players, board.slots)
		game.play
		expect(board.full?).to be true
		expect(game.winner).to be false
	end
end

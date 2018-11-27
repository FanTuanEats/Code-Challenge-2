require 'spec_helper'
require_relative '../../lib/tic_tac_toe/player'

RSpec.describe TicTacToe::Player do
	include_examples "behaves like a player", 'X', 'Computer'
end

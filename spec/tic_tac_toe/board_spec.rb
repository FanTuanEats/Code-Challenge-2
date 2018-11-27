require 'spec_helper'
require_relative './../../lib/tic_tac_toe/board'

RSpec.describe TicTacToe::Board do
	let(:cols) { 4 }
	let(:rows) { 4 }
	let(:board) { described_class.new(cols, rows, nil) }

	it { expect(board).to be_an_instance_of(described_class) }

	context "initializing" do
		it "should have attribute cols set" do
			expect(board.cols).to eql(cols)
		end

		it "should have attribute rows set" do
			expect(board.rows).to eql(rows)
		end

		it "should have cols*rows number of slots" do
			expect(board.slots.keys.length).to eql(cols*rows)
		end

		it "should have all slots set to nil" do
			all_nil = board.slots.values.all?(&:nil?)
			expect(all_nil).to be true
		end
	end

	context "playing" do
		it "should be able to print the board" do
			expect(board.print).to eql(" 1| 2| 3| 4\n 5| 6| 7| 8\n 9|10|11|12\n13|14|15|16")
		end

		it "should be able to mark a slot if slot is available" do
			symbol = 'X'
			slot = 1
			slot_added = board.set_slot(symbol, slot)
			expect(slot_added).to be symbol
		end
	end
end

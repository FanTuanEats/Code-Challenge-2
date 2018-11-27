require 'pry'
module TicTacToe
	class HumanPlayer < Player
		def initialize(symbol, name)
			super(symbol, name)
		end

		def play(game)
			puts "\n[#{name}] Select a slot number:\n\n"
			puts game.board.print
			print "\nSlot: "
			slot = get_slot_input
			set_slot(slot, game.board)
		end

		private

		def get_slot_input
			gets.chomp.to_i
		end
	end
end

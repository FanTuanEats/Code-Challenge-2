module TicTacToe
	class ComputerPlayer < Player
		STRATEGIES = { 1 => "random", 2 => "mini_max" }.freeze

		def initialize(symbol, name)
			super(symbol, name)
		end

		def play(game)
			slot = send(game.strategy, game)
			puts "\n[#{name}] Played slot number #{slot} ...\n\n"
			set_slot(slot, game.board).tap do
				puts game.board.print
			end
		end

		private

		def random(game)
			game.board.playable_slots.sample
		end

		def mini_max(game)
			return score(game) if game.over?

			scores = []

			game.board.playable_slots.each do |slot|
				possible_game = game.possible_game(slot)
				score = mini_max(possible_game)[0]
				scores << [score, slot]
			end

			if game.current_player.symbol == @symbol
				scores.max[1]
			else
				scores.min[1]
			end
		end

		def score(game)
			if !game.winner
				0
			elsif game.winner.symbol == @symbol
				+1
			elsif game.winner.symbol == game.human_player.symbol
				-1
			end
		end
	end
end

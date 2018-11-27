module TicTacToe
	class Game
		TOTAL_SLOTS_WITH_SAME_SYMBOL = 3.freeze
		SYMBOLS = ['X', 'O'].freeze

		attr_reader :board, :strategy, :human_player, :winner, :winning_combinations

		def initialize(strategy, players, slots = nil)
			@players = players
			#####
			# HERE YOU CAN CHANGE THE BOARD SIZE (4X4 IS THE DEFAULT)
			@board = TicTacToe::Board.new(4, 4, slots)
			#####
			@strategy = TicTacToe::ComputerPlayer::STRATEGIES[strategy]
		end

		def play
			until over?
				next_turn!

				until current_player.play(self)
					puts "\n[GAME] Slot already taken or invalid, please try again!\n"
				end
			end

			message = winner? ? "#{winner.name} won!" : "It's a draw!"
			puts "\n\n*********************************"
			puts "[GAME OVER] #{message}"
			puts "*********************************\n\n"
			puts @board.print
		end

		def over?
			winner? || draw?
		end

		def possible_game(slot)
			board = @board.possible_board(current_player.symbol, slot)
			self.class.new(@strategy, next_turn, board.slots)
		end

		def current_player
			@players[0]
		end

		def human_player
			@human_player ||= @players.detect{|p| p.kind_of?(TicTacToe::HumanPlayer)}
		end

		private

		def next_turn!
			@players.rotate!
		end

		def next_turn
			@players.rotate
		end

		def draw?
			@board.full? && !winner?
		end

		def winner?
			return @winner if @winner

			@winning_combinations ||= build_winning_combinations

			@winning_combinations.each do |winning_line|
				self.winner = @players.detect do |player|
					winning_line.all? { |slot| @board.slots[slot] == player.symbol }
				end
				break if @winner
			end

			@winner
		end

		def winner=(obj)
			@winner = obj.nil? ? false : obj
		end

		def build_winning_combinations
			cols = (0...(@board.cols - 2)).to_a
			rows = (1...(@board.rows - 2)).to_a
			winning_combinations = []

			horizontals = @board.slots.keys.each_slice(@board.cols).to_a
			verticals = horizontals.transpose
			diagonals = []

			# Build diagonals iterating by columns
			cols.each do |n|
				cursor = n
				diagonal_htlr = [] # Horizontal-Top from Left to Right
				diagonal_htrl = [] # Horizontal-Top from Right to Left

				horizontals.length.times do |index|
					diagonal_htlr << horizontals[index][cursor]
					diagonal_htrl << horizontals[index][-cursor-1]
					cursor += 1
				end

				diagonals.push(
					diagonal_htlr.compact,
					diagonal_htrl.compact
				)
			end

			# Build diagonals iterating by rows
			rows.each do |n|
				cursor = n
				diagonal_vltb = [] # Vertical-Left from Top to Bottom
				diagonal_vrtb = [] # Vertical-Right from Top to Bottom

				verticals.length.times do |index|
					diagonal_vltb << verticals[index][cursor]
					diagonal_vrtb << verticals[-index-1][cursor]
					cursor += 1
				end

				diagonals.push(
					diagonal_vltb.compact,
					diagonal_vrtb.compact
				)
			end

			# Joining everything in one array
			lines = [*horizontals, *verticals, *diagonals]

			lines.each do |line|
				(line.length - 2).times do |n|
					# Slice n times each line (3 slots each slice)
					winning_combinations << line.slice(n, TOTAL_SLOTS_WITH_SAME_SYMBOL)
				end
			end

			winning_combinations
		end
	end
end

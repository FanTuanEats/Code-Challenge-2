module TicTacToe
	class Board
		attr_accessor :slots
		attr_reader :cols, :rows

		def initialize(cols, rows, slots = nil)
			@cols = cols
			@rows = rows
			@slots = slots || create_slots
		end

		def print
			cursor = 0
			board_lines = []
			@rows.times do
				board_slots = []
				@cols.times do
					cursor += 1
					board_slots << (@slots[cursor].nil? ? cursor.to_s : @slots[cursor]).rjust(2, ' ')
				end
				board_lines << board_slots.join('|')
			end
			board_lines.join("\n")
		end

		def set_slot(symbol, slot)
			return false if !playable_slots.include?(slot)
			slots[slot] = symbol
		end

		def playable_slots
			@slots.select{|k,v| v.nil?}.keys
		end

		def possible_board(symbol, slot)
			board = self.class.new(@cols, @rows, @slots.dup)
			board.set_slot(symbol, slot)
			board
		end

		def full?
			!@slots.values.include?(nil)
		end

		private

		def create_slots
			@slots ||= {}
			(@cols*@rows).times do |slot|
				@slots[slot + 1] = nil
			end
			@slots
		end
	end
end

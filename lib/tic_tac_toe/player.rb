module TicTacToe
	class Player
		attr_reader :symbol
		attr_reader :name

    def initialize(symbol, name)
			@symbol = symbol
			@name = name.to_s.upcase
		end

		def set_slot(slot, board)
			board.set_slot(@symbol, slot)
		end
  end
end

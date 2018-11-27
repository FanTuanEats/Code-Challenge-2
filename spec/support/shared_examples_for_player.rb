RSpec.shared_examples "behaves like a player" do |symbol, name|
	let(:player) { described_class.new(symbol, name) }
	let(:board) { TicTacToe::Board.new(4, 4) }

	it { expect(player).to be_an_instance_of(described_class) }

	it "should have attribute name set" do
		expect(player.name).to eql(name.to_s.upcase)
	end

	it "should have attribute symbol set" do
		expect(player.symbol).to eql(symbol)
	end

	it "should be able to set a slot" do
		game = double('game')
		slot = 12
		allow(game).to receive(:board).and_return(board)
		expect(player.set_slot(slot, board)).to eq symbol
	end
end

require_relative "../src/computer_player"

RSpec.describe ComputerPlayer, type: :model do
  it { should validate_presence_of(:strategy_id) }
  it { should validate_inclusion_of(:strategy_id).in_range(1..2) }
end

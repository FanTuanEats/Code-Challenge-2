require_relative "../src/player"

RSpec.describe Player, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:token) }
end

require "active_model"

class Player
  include ActiveModel::Validations

  attr_accessor :name, :token

  validates_presence_of :name, :token

  def initialize(name: nil, **args)
    @name = name
    @token = name[0]
  end

  def play_gamepiece(column_number)
    column_index = column_number - 1
    drop_gamepiece(column_index, token)
  end
end

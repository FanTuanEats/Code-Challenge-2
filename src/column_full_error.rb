require_relative 'user_input_error'

class ColumnFullError < UserInputError
  def initialize(message = "Whoa there, bucco! The column you picked is already full!.")
    super(message)
  end
end

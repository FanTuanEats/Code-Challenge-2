require_relative "user_input_error"

module Validations
  def validate_numerical_input(input, range)
    raise UserInputError unless range.include?(input)
  end
end

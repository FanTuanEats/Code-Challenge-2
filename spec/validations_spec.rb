require_relative "../src/validations"

RSpec.describe Validations, "#validate_numerical_input" do
  include Validations
  it "raises an error for a string as input" do
    input = "sdfa"
    range = (1..10)
    expect{validate_numerical_input(input, range)}.to raise_error(UserInputError)
  end
  it "raises an error for nil" do
    input = nil
    range = (1..10)
    expect{validate_numerical_input(input, range)}.to raise_error(UserInputError)
  end
  it "raises an error for a number greater than range" do
    input = 11
    range = (1..10)
    expect{validate_numerical_input(input, range)}.to raise_error(UserInputError)
  end
  it "raises an error for a number less than range" do
    input = 0
    range = (1..10)
    expect { validate_numerical_input(input, range) }.to raise_error(UserInputError)
  end
end

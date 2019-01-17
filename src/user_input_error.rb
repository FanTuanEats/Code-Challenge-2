class UserInputError < RuntimeError
  def initialize(message = "Whoa there, bucco! You must have mistyped something.")
    super(message)
  end
end

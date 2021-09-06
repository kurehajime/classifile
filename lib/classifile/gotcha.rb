# frozen_string_literal: true

# Find save directory signal
class Gotcha < StandardError
  attr_accessor :path, :file_name

  def initialize(path, file_name)
    @path = path
    @file_name = file_name
    super()
  end
end

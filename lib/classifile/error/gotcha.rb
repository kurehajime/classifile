# frozen_string_literal: true

module Classifile
  ##
  # Exception thrown when the directory to be saved is found.
  # Caught on the outside of DSL
  class Gotcha < StandardError
    attr_accessor :path, :file_name

    def initialize(path, file_name)
      @path = path
      @file_name = file_name
      super()
    end
  end
end

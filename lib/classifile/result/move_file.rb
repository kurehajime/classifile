# frozen_string_literal: true

module Classifile
  ##
  # Source and destination classes for file
  class MoveFile < Classifile::Result
    attr_accessor :to

    def initialize(from, to)
      @to = to
      super from
    end
  end
end

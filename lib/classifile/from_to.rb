# frozen_string_literal: true

##
# Source and destination classes for file
class FromTo
  attr_accessor :from, :to

  def initialize(from, to)
    @from = from
    @to = to
  end
end

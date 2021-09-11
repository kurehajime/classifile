# frozen_string_literal: true

##
# Source and destination classes for file
class FromTo
  attr_accessor :from, :to, :after_save_procs

  def initialize(from, to)
    @from = from
    @to = to
    @after_save_procs = []
  end
end

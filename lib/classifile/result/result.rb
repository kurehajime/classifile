# frozen_string_literal: true

module Classifile
  ##
  # Result for classify
  class Result
    attr_accessor :from, :after_save_procs

    def initialize(from)
      @from = from
      @after_save_procs = []
    end
  end
end

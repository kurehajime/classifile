# frozen_string_literal: true

module Classifile
  ##
  # Check the file name
  module NameChecker
    attr_accessor :name

    ##
    # Whether the file name contains any of the target string
    def include?(*patterns)
      patterns.each do |p|
        return nil if _include?(p)
      end
      raise NoGotcha
    end

    ##
    # Whether the file name ends with one of the target strings
    def end_with?(*patterns)
      patterns.each do |p|
        return nil if _end_with?(p)
      end
      raise NoGotcha
    end

    private

    def _include?(pattern)
      @name.downcase.include?(pattern.downcase)
    end

    def _end_with?(pattern)
      @name.downcase.end_with?(pattern.downcase)
    end
  end
end

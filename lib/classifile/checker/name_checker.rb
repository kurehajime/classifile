# frozen_string_literal: true

module Classifile
  # Name Check
  module NameChecker
    attr_accessor :name

    def include?(*patterns)
      patterns.each do |p|
        return nil if _include?(p)
      end
      raise NoGotcha
    end

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

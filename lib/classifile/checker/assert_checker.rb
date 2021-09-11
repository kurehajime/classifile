# frozen_string_literal: true

require "minitest/assertions"

# Classifile
module Classifile
  ##
  # Wrapper class for Minitest::Assertions.
  # Wrap and convert to Failed error
  # when minitest's Assert method is called.
  module AssertChecker
    # include Minitest:Assertion
    class Asserter
      include Minitest::Assertions
      attr_accessor :assertions, :failure

      def initialize
        self.assertions = 0
        self.failure = nil
      end
    end

    ##
    # Provides assert methods of minitest.
    def method_missing(name, *args)
      @assert = Asserter.new if @assert.nil?
      unless @assert.respond_to?(name) && name.to_s.include?("assert")
        raise NoMethodError.new("Method '#{name}' not found", name)
      end

      begin
        @assert.send name, *args
      rescue MiniTest::Assertion
        raise Failed unless @gotcha
      end
    end

    def respond_to_missing?(sym, *)
      if sym.to_s.include?("assert")
        @assert.respond_to?(sym) ? true : super
      else
        super
      end
    end
  end
end

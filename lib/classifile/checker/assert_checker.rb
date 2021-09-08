# frozen_string_literal: true

require "minitest/assertions"

# Classifile
module Classifile
  # Wrap of Minitest:Assertion
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

    @assert = Asserter.new

    def method_missing(name, *args)
      raise NoMethodError.new "Method '#{name}' not found", name unless @assert.respond_to?(name)

      begin
        @assert.send name, *args
      rescue MiniTest::Assertion
        raise NoGotcha
      end
    end

    def respond_to_missing?(sym, *)
      @assert.respond_to?(sym)
    end
  end
end

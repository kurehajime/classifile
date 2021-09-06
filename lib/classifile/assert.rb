# frozen_string_literal: true

require "minitest/assertions"
# Wrap of Minitest:Assertion
class Assert
  # include Minitest:Assertion
  class Asserter
    include Minitest::Assertions
    attr_accessor :assertions, :failure

    def initialize
      self.assertions = 0
      self.failure = nil
    end
  end

  def initialize
    @assert = Asserter.new
  end

  def method_missing(name, *args)
    raise NoMethodError unless @assert.respond_to?(name)

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

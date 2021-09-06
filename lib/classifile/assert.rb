require 'minitest/assertions'

class Assert
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
      raise NoGotcha.new
    end
  end

  def respond_to?(sym, *)
    @assert.respond_to?(sym) || super
  end

end
# frozen_string_literal: true

require "minitest/assertions"

# Classifile
module Classifile
  ##
  # Minitest::Assertionsのラッパークラス。
  # minitestに存在するAssert系メソッドが呼ばれた際に
  # ラップしてNoGotchaエラーに変換する。
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
    # minitestのassert系メソッドを提供
    def method_missing(name, *args)
      @assert = Asserter.new if @assert.nil?
      unless @assert.respond_to?(name) && name.to_s.include?("assert")
        raise NoMethodError.new("Method '#{name}' not found", name)
      end

      begin
        @assert.send name, *args
      rescue MiniTest::Assertion
        raise NoGotcha
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

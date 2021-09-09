# frozen_string_literal: true

require_relative "../test_helper"

class AssertCheckerTest < Minitest::Test
  class Checker
    include Classifile::AssertChecker
  end

  def test_assert
    checker = Checker.new
    checker.assert true
    assert_raises Classifile::NoGotcha do
      checker.assert false
    end
    assert_raises Classifile::NoGotcha do
      checker.assert_includes %w[Pikachu Dragonite Slowbro Pigeotto], "imakuni?"
    end
  end

  def test_no_assert
    checker = Checker.new
    checker.assert true
    assert_raises NoMethodError do
      checker.assert_foo
    end
  end
end
# frozen_string_literal: true

require_relative "../test_helper"

class AssertCheckerTest < Minitest::Test
  class Checker
    include Classifile::AssertChecker
  end

  def test_assert
    checker = Checker.new
    checker.assert true
    assert_raises Classifile::Failed do
      checker.assert false
    end
    assert_raises Classifile::Failed do
      checker.assert_includes %w[Pikachu Dragonite Slowbro Pigeotto], "imakuni?"
    end
  end

  # noinspection RubyResolve
  def test_non_exist_assert_method
    checker = Checker.new
    checker.assert true
    assert_raises NoMethodError do
      checker.assert_foo
    end
    assert_raises NoMethodError do
      checker.foo_bar
    end
  end

  # noinspection RubyResolve
  def test_respond_to
    checker = Checker.new
    assert(checker.respond_to?(:assert))
    assert !(checker.respond_to? :foo)
  end
end

# frozen_string_literal: true

require_relative "../test_helper"

class NameCheckerTest < Minitest::Test
  class Checker
    include Classifile::NameChecker
  end

  def test_include
    checker = Checker.new
    checker.name = "hoge"
    checker.include? "hoge"
    assert_raises Classifile::Failed do
      checker.include? "foo", "bar"
    end
  end

  def test_end_with
    checker = Checker.new
    checker.name = "hoge.txt"
    checker.end_with? ".txt"
    assert_raises Classifile::Failed do
      checker.end_with? "hoge", ".png", ".zip"
    end
  end
end

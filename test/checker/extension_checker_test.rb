# frozen_string_literal: true

require_relative "../test_helper"

class ExtensionCheckerTest < Minitest::Test
  class Checker
    include Classifile::ExtensionChecker
  end

  def test_check_extension
    checker = Checker.new
    checker.extname = ".jpg"
    checker.image?
    assert_raises Classifile::NoGotcha do
      checker.sound?
    end
    assert_raises Classifile::NoGotcha do
      checker.movie?
    end
  end
end

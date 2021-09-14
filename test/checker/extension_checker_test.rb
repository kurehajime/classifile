# frozen_string_literal: true

require_relative "../test_helper"

class ExtensionCheckerTest < Minitest::Test
  class Checker
    include Classifile::ExtensionChecker
  end

  def setup
    @checker = Checker.new
  end

  def test_check_image
    Classifile::FILE_TYPE_IMAGE.each do |ext|
      @checker.extname = ext
      @checker.image?
      assert_raises Classifile::Failed do
        @checker.sound?
      end
      assert_raises Classifile::Failed do
        @checker.movie?
      end
    end
  end

  def test_check_sound
    Classifile::FILE_TYPE_SOUND.each do |ext|
      @checker.extname = ext
      @checker.sound?
      assert_raises Classifile::Failed do
        @checker.image?
      end
      assert_raises Classifile::Failed do
        @checker.movie?
      end
    end
  end

  def test_check_movie
    Classifile::FILE_TYPE_MOVIE.each do |ext|
      @checker.extname = ext
      @checker.movie?
      assert_raises Classifile::Failed do
        @checker.image?
      end
      assert_raises Classifile::Failed do
        @checker.sound?
      end
    end
  end
end

# frozen_string_literal: true

require "test_helper"

class ClassifyTest < Minitest::Test
  def setup
    begin
      f = File.open("./sandbox/dsl/dsl.rb")
      dsl = f.read
    ensure
      f.close
    end
    @proc = proc do
      eval dsl # rubocop:disable all
    end
  end

  def test_this_has_a_version_number
    refute_nil ::Classifile::VERSION
  end

  def test_assert_match
    fs = Classify.new
    target_file = TargetFile.new("/tmp/dog.png")
    result = fs.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_equal result.path, "/Images/Favorites/Dogs" if result
  end

  def test_nest_dir
    fs = Classify.new
    target_file = TargetFile.new("/tmp/kitten.png")
    result = fs.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_equal result.path, "/Images/Favorites/Cats/Kittens" if result
  end

  def test_empty_dir
    fs = Classify.new
    target_file = TargetFile.new("/tmp/dragon.png")
    result = fs.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_equal result.path, "/Images/Others" if result
  end

  def test_year_dir
    fs = Classify.new
    target_file = TargetFile.new("/tmp/hello.txt")
    target_file.atime = Time.local(1999, 11, 21, 12, 34, 56, 7)
    result = fs.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_equal result.path, "/Documents/1999" if result
  end

  def test_can_not_save
    fs = Classify.new
    target_file = TargetFile.new("/tmp/kitten.zip")
    result = fs.run(target_file, "/", &@proc)

    assert_nil result
  end

  def test_temp

  end

end

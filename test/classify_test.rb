# frozen_string_literal: true

require_relative "test_helper"

class ClassifyTest < Minitest::Test
  def setup
    @proc = proc do
      eval Classifile::FileTools.read_dsl("./sandbox/dsl/dsl.rb") # rubocop:disable all
    end
  end

  def test_this_has_a_version_number
    refute_nil Classifile::VERSION
  end

  def test_simple_match
    cfy = Classifile::Classify.new
    target_file = Classifile::TargetFile.new("/tmp/dog.png")
    result = cfy.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_includes result.to ,"/Images/Favorites/Dogs"   if result
  end

  def test_nest_dir
    cfy = Classifile::Classify.new
    target_file = Classifile::TargetFile.new("/tmp/kitten.png")
    result = cfy.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_includes result.to, "/Images/Favorites/Cats/Kittens" if result
  end

  def test_multi_names
    cfy = Classifile::Classify.new
    target_file = Classifile::TargetFile.new("/tmp/penguin.png")
    result = cfy.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_includes result.to, "/Images/Birds" if result
  end

  def test_empty_dir
    cfy = Classifile::Classify.new
    target_file = Classifile::TargetFile.new("/tmp/dragon.png")
    result = cfy.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_includes result.to, "/Images/Others" if result
  end

  def test_year_dir
    cfy = Classifile::Classify.new
    target_file = Classifile::TargetFile.new("/tmp/hello.txt")
    target_file.atime = Time.local(1999, 11, 21, 12, 34, 56, 7)
    result = cfy.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_includes result.to, "/Documents/1999" if result
  end

  def test_group
    fs = Classifile::Classify.new
    target_file = Classifile::TargetFile.new("/tmp/hello.zip")
    target_file.atime = Time.local(1999, 11, 21, 12, 34, 56, 7)
    result = fs.run(target_file, "/", &@proc)

    assert !result.nil?
    assert_includes result.to, "/1999" if result
  end

  def test_can_not_save
    cfy = Classifile::Classify.new
    target_file = Classifile::TargetFile.new("/tmp/kitten.html")
    result = cfy.run(target_file, "/", &@proc)

    assert_nil result
  end

  def test_temp; end
end

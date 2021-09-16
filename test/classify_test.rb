# frozen_string_literal: true

require_relative "test_helper"

class ClassifyTest < Minitest::Test
  def setup
    @cfy = Classifile::Classify.new
    @proc = proc do
      eval Classifile::FileTools.read_dsl("./sandbox/dsl/dsl.rb") # rubocop:disable all
    end
  end

  def test_this_has_a_version_number
    refute_nil Classifile::VERSION
  end

  def test_simple_match
    target_file = Classifile::TargetFile.new("/tmp/dog.png")
    result = @cfy.run(target_file, "/", &@proc)

    assert_instance_of Classifile::MoveFile, result
    assert_includes result.to, "/Images/Favorites/Dogs" if result.is_a? Classifile::MoveFile
  end

  def test_nest_dir
    target_file = Classifile::TargetFile.new("/tmp/kitten.png")
    result = @cfy.run(target_file, "/", &@proc)

    assert_instance_of Classifile::MoveFile, result
    assert_includes result.to, "/Images/Favorites/Cats/Kittens" if result.is_a? Classifile::MoveFile
  end

  def test_multi_names
    target_file = Classifile::TargetFile.new("/tmp/penguin.png")
    result = @cfy.run(target_file, "/", &@proc)

    assert_instance_of Classifile::MoveFile, result
    assert_includes result.to, "/Images/Birds" if result.is_a? Classifile::MoveFile
  end

  def test_empty_dir
    target_file = Classifile::TargetFile.new("/tmp/dragon.png")
    result = @cfy.run(target_file, "/", &@proc)

    assert_instance_of Classifile::MoveFile, result
    assert_includes result.to, "/Images/Others" if result.is_a? Classifile::MoveFile
  end

  def test_year_dir
    target_file = Classifile::TargetFile.new("/tmp/hello.txt")
    target_file.atime = Time.local(1999, 11, 21, 12, 34, 56, 7)
    result = @cfy.run(target_file, "/", &@proc)

    assert_instance_of Classifile::MoveFile, result
    assert_includes result.to, "/Documents/1999" if result.is_a? Classifile::MoveFile
  end

  def test_group
    target_file = Classifile::TargetFile.new("/tmp/hello.zip")
    target_file.atime = Time.local(1999, 11, 21, 12, 34, 56, 7)
    result = @cfy.run(target_file, "/", &@proc)

    assert_instance_of Classifile::MoveFile, result
    assert_includes result.to, "/1999" if result.is_a? Classifile::MoveFile
  end

  def test_can_not_save
    target_file = Classifile::TargetFile.new("/tmp/kitten.html")
    result = @cfy.run(target_file, "/", &@proc)

    assert_nil result
  end

  def test_after_save
    target_file = Classifile::TargetFile.new("/tmp/hello.md")
    result = @cfy.run(target_file, "/", &@proc)

    assert_instance_of Classifile::MoveFile, result
    assert_equal 1, result.after_save_procs.length
  end

  def test_del
    target_file = Classifile::TargetFile.new("/tmp/hello.tmp")
    result = @cfy.run(target_file, "/", &@proc)

    assert_instance_of Classifile::RemoveFile, result
  end
end

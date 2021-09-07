require "test_helper"

class FileToolsTest < Minitest::Test
  def setup
    FileTools.copy_mode # move -> copy
  end

  def teardown
    FileUtils.remove_entry_secure("./sandbox/to") if File.exist?("./sandbox/to")
  end

  def test_get_file_list
    assert FileTools.get_file_list("./sandbox/from/*")[0].include?("/sandbox/from/test.txt")
  end

  def test_move_with_test_mode
    FileTools.move("./sandbox/from/test.txt", "./sandbox/to/foo/bar/test.txt")
    assert File.exist?("./sandbox/to/foo/bar/test.txt")
  end
end
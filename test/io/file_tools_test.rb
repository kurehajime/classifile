# frozen_string_literal: true

require_relative "../test_helper"

class FileToolsTest < Minitest::Test
  def setup; end

  def teardown
    FileUtils.remove_entry_secure("./sandbox/to") if File.exist?("./sandbox/to")
  end

  def test_get_file_list
    assert Classifile::FileTools.get_file_list("./sandbox/from/*")[2].include?("/sandbox/from/test.txt")
    assert Classifile::FileTools.get_file_list("./sandbox/from")[2].include?("/sandbox/from/test.txt")
    assert Classifile::FileTools.get_file_list("./sandbox/from/")[2].include?("/sandbox/from/test.txt")
    assert Classifile::FileTools.get_file_list("./sandbox/from/test.txt")[0].include?("/sandbox/from/test.txt")
  end

  def test_move_with_test_mode
    Classifile::FileTools.move("./sandbox/from/test.txt", "./sandbox/to/foo/bar/test.txt", copy: true)
    assert File.exist?("./sandbox/to/foo/bar/test.txt")
  end

  def test_fail_read_dsl
    cap = capture_io do
      Classifile::FileTools.read_dsl("./sandbox/dsl/not_found_dsl.rb")
    end
    assert_includes cap[0], "No such file or directory"
  end
end

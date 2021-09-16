# frozen_string_literal: true

require_relative "test_helper"

class ExecuteTest < Minitest::Test
  def setup
    @exe = Classifile::Execute.new
  end

  def teardown
    FileUtils.remove_entry_secure("./sandbox/to") if File.exist?("./sandbox/to")
    FileUtils.remove_entry_secure("./sandbox/temp") if File.exist?("./sandbox/temp")
  end

  def test_execute_test
    %w[./sandbox/from/* ./sandbox/from/ ./sandbox/from].each do |from|
      std = capture_io do
        @exe.test "./sandbox/dsl/dsl.rb", from, "./sandbox/to"
      end
      assert_includes std[0], "sandbox/to/Markdown/hello.md"
      assert_match %r{to/Documents/\d\d\d\d/test.txt}, std[0]
      assert_match %r{to/Documents/\d\d\d\d/xyz.txt}, std[0]
      assert_equal "", std[1] # no error
    end
  end

  def test_execute_copy
    %w[./sandbox/from/*].each do |from|
      capture_io do
        @exe.copy "./sandbox/dsl/dsl.rb", from, "./sandbox/to"
      end
    end
    assert File.exist?("./sandbox/to/Markdown/hello.md")
  end

  def test_execute_move
    FileUtils.cp_r("./sandbox/from", "./sandbox/temp")
    %w[./sandbox/temp/*].each do |from|
      capture_io do
        @exe.move "./sandbox/dsl/dsl.rb", from, "./sandbox/to"
      end
    end
    assert File.exist?("./sandbox/to/Markdown/hello.md")
    assert !File.exist?("./sandbox/temp/hello.md")
  end
end

# frozen_string_literal: true

require "test_helper"

class ClassifileTest < Minitest::Test
  def setup
    @proc = proc do
      dir "Images" do
        assert @file.is_image?
        dir "Favorites" do
          empty_dir

          dir "Dogs" do
            assert @file.basename.downcase.include?("dog")
          end

          dir "Cats" do
            dir "Kitten" do
              assert @file.basename.downcase.include?("kitten")
            end
            assert @file.basename.downcase.include?("cat")
          end
        end

        dir "Others" do
        end
      end

      dir "Movies" do
        assert @file.is_movie?
      end

      dir "Sounds" do
        assert @file.is_sound?
      end

      dir "Docs" do
        assert %w[.txt .pdf .doc .xls .ppt .docx .xlsx .pptx].include?(@file.extname)
        dir @file.atime.year.to_s do
        end
      end
    end
  end

  def test_that_it_has_a_version_number
    refute_nil ::Classifile::VERSION
  end

  def test_can_save
    fs = Classify.new
    target_file = TargetFile.new("/tmp/kitten.png")
    result = fs.run(target_file, "/", &@proc)

    assert result != nil
    if result
      assert_equal result.path , "/Images/Favorites/Cats/Kitten"
    end
  end

  def test_year_dir
    fs = Classify.new
    target_file = TargetFile.new("/tmp/hello.txt")
    target_file.atime = Time.local(1999, 11, 21, 12, 34, 56, 7)
    result = fs.run(target_file, "/", &@proc)

    assert result != nil
    if result
      assert_equal result.path , "/Docs/1999"
    end
  end

  def test_can_not_save
    fs = Classify.new
    target_file = TargetFile.new("/tmp/kitten.zip")
    result = fs.run(target_file, "/", &@proc)

    assert_nil result
  end

end

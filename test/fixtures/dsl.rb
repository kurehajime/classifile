dir "Images" do
  assert this.image?
  dir "Favorites" do
    empty_dir

    dir "Dogs" do
      assert_match "dog", this.basename
    end

    dir "Cats" do
      dir "Kittens" do
        assert_match "kitten", this.basename
      end
      assert_match "cat", this.basename
    end
  end

  dir "Others" do
  end
end

dir "Movies" do
  assert this.movie?
end

dir "Sounds" do
  assert this.sound?
end

dir "Documents" do
  assert_includes %w[.txt .pdf .doc .xls .ppt .docx .xlsx .pptx], this.extname
  dir this.atime.year.to_s do
  end
end
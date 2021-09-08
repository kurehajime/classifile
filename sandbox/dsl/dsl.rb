# frozen_string_literal: true

dir "Images" do
  assert this.image?
  dir "Favorites" do
    empty_dir

    dir "Dogs" do
      include? "dog"
    end

    dir "Cats" do
      dir "Kittens" do
        include? "kitten"
      end
      include? "cat"
    end
  end

  dir "Birds" do
    include? "bird", "duck", "parrot", "cock", "rooster", "goose", "canary", "mallard", "wild duck", "sea gull",
             "crow", "pheasant", "woodpecker", "peacock", "stork", "turkey", "sparrow", "hawk", "ostrich",
             "swallow", "crane", "bird", "nest", "chickek", "chick", "swan", "pigeon", "lark", "owl", "flamingo",
             "pelican", "penguin", "hen", "eagle"
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

dir "Documents" do |file|
  assert_includes %w[.txt .pdf .doc .xls .ppt .docx .xlsx .pptx], this.extname
  if file.atime
    dir file.atime.year.to_s do
    end
  end
end

group "Years Directory" do |file|
  assert_includes %w[.zip], file.extname
  if file.atime
    dir file.atime.year.to_s do
    end
  end
end

# frozen_string_literal: true

module Classifile
  # File Utility
  class FileTools
    def self.get_file_list(path)
      ex_path = File.expand_path(path) # for Windows
      if !File.exist?(ex_path) # if foo/* pattern
        Dir.glob(ex_path)
      elsif File.ftype(ex_path) == "directory"
        Dir.glob(File.join(ex_path, "*"))
      else
        [ex_path]
      end
    end

    def self.move(src, dest, copy: false)
      dir = File.dirname(dest).to_s
      FileUtils.mkpath(dir)

      if copy
        FileUtils.copy(src, dest)
      else
        FileUtils.move(src, dest)
      end
    end
  end
end
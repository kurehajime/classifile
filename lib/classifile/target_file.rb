# frozen_string_literal: true

require "pathname"
module Classifile
  # Target File
  class TargetFile
    attr_accessor :dirname, :full_path, :basename, :pure_basename, :atime, :ctime, :size, :extname

    def initialize(full_path)
      path_name = Pathname.new(full_path)
      @full_path = full_path
      @dirname = dirname
      @basename = path_name.basename(full_path).to_s
      @pure_basename = path_name.basename(full_path).to_s.split(".")[0]
      @extname = path_name.extname
    end

    def self.build_by_file(full_path)
      TargetFile.new(full_path)
    end
  end
end

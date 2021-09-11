# frozen_string_literal: true

require "pathname"
module Classifile
  ##
  # Class representing the target file
  class TargetFile
    attr_accessor :dirname, :full_path, :basename, :pure_basename, :atime, :ctime, :size, :extname, :to_path

    def initialize(full_path)
      path_name = Pathname.new(full_path)
      @full_path = full_path
      @dirname = dirname
      @basename = path_name.basename(full_path).to_s
      @pure_basename = path_name.basename(full_path).to_s.split(".")[0]
      @extname = path_name.extname
    end

    def self.build_by_file(full_path)
      fs = File.stat(full_path)
      tf = TargetFile.new(full_path)
      tf.atime = fs.atime
      tf.ctime = fs.ctime
      tf.size = fs.size
      tf
    end
  end
end

# frozen_string_literal: true

require "Pathname"

class TargetFile
  attr_accessor :dirname, :full_path, :basename, :pure_basename,  :atime, :ctime, :size

  include ::Ext

  def initialize(full_path, file_stat = nil)
    path_name = Pathname.new(full_path)
    @full_path = full_path
    @dirname = dirname
    @basename = path_name.basename(full_path).to_s
    @pure_basename = path_name.basename(full_path).to_s.split(".")[0]
    @extname = path_name.extname
    if file_stat
      @atime = file_stat.attime
      @ctime = file_stat.ctime
      @size = file_stat.size
    end
  end

end

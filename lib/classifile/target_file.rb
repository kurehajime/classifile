# frozen_string_literal: true

require "Pathname"

class TargetFile
  attr_accessor :dirname, :full_path, :basename, :pure_basename, :extname, :atime, :ctime, :size

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

  def is_image?
    %w[.gif .jpg .jpeg .jpe .jfif .png .bmp .dib .rle .ico .ai .art .psd .tif .tiff .nsk .webp].include?(@extname)
  end

  def is_sound?
    %w[.mp3 .wma .asf .3gp .3g2 .aac .ogg .oga .mov .m4a .alac .flac .wav].include?(@extname)
  end

  def is_movie?
    %w[.avi .flv .mpg .mpeg .mp4 .mkv .mov .qt .wmv .asf .m2ts .ts .m4a .webm .ogm].include?(@extname)
  end
end

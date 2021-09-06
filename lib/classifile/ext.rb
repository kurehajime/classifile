# frozen_string_literal: true

# Extension Utility
module Ext
  attr_accessor :extname

  def image?
    %w[.gif .jpg .jpeg .jpe .jfif .png .bmp .dib .rle .ico .ai .art .psd .tif .tiff .nsk .webp].include?(@extname)
  end

  def sound?
    %w[.mp3 .wma .asf .3gp .3g2 .aac .ogg .oga .mov .m4a .alac .flac .wav].include?(@extname)
  end

  def movie?
    %w[.avi .flv .mpg .mpeg .mp4 .mkv .mov .qt .wmv .asf .m2ts .ts .m4a .webm .ogm].include?(@extname)
  end
end

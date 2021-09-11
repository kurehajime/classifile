# frozen_string_literal: true

module Classifile
  ##
  # Check the file extension to see the file type.
  module ExtensionChecker
    attr_accessor :extname

    def image?
      raise Failed if !@gotcha && !FILE_TYPE_IMAGE.include?(@extname)
    end

    def sound?
      raise Failed if !@gotcha && !FILE_TYPE_SOUND.include?(@extname)
    end

    def movie?
      raise Failed if !@gotcha && !FILE_TYPE_MOVIE.include?(@extname)
    end
  end
end

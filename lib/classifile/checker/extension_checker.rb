# frozen_string_literal: true

module Classifile
  ##
  # Check the file extension to see the file type.
  module ExtensionChecker
    attr_accessor :extname

    def image?
      raise Failed unless FILE_TYPE_IMAGE.include?(@extname) unless @gotcha
    end

    def sound?
      raise Failed unless FILE_TYPE_SOUND.include?(@extname) unless @gotcha
    end

    def movie?
      raise Failed unless FILE_TYPE_MOVIE.include?(@extname) unless @gotcha
    end
  end
end

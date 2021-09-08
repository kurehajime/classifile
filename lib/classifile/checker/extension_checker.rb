# frozen_string_literal: true

module Classifile
  # Extension Utility
  module ExtensionChecker
    attr_accessor :extname

    def image?
      raise NoGotcha unless FILE_TYPE_IMAGE.include?(@extname)
    end

    def sound?
      raise NoGotcha unless FILE_TYPE_SOUND.include?(@extname)
    end

    def movie?
      raise NoGotcha unless FILE_TYPE_MOVIE.include?(@extname)
    end
  end
end
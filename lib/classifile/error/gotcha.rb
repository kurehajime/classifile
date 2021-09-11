# frozen_string_literal: true

module Classifile
  ##
  # 保存するディレクトリが見つかった時に投げられる例外
  # DSLの外側で補足される
  class Gotcha < StandardError
    attr_accessor :path, :file_name

    def initialize(path, file_name)
      @path = path
      @file_name = file_name
      super()
    end
  end
end

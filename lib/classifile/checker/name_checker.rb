# frozen_string_literal: true

module Classifile
  ##
  # ファイル名を確認
  module NameChecker
    attr_accessor :name

    ##
    # ファイル名が対象の文字のいずれかを含むか
    def include?(*patterns)
      patterns.each do |p|
        return nil if _include?(p)
      end
      raise NoGotcha
    end

    ##
    # ファイル名が対象の文字のいずれかで終わるか
    def end_with?(*patterns)
      patterns.each do |p|
        return nil if _end_with?(p)
      end
      raise NoGotcha
    end

    private

    def _include?(pattern)
      @name.downcase.include?(pattern.downcase)
    end

    def _end_with?(pattern)
      @name.downcase.end_with?(pattern.downcase)
    end
  end
end

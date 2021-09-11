# frozen_string_literal: true

# Classifile
module Classifile
  ##
  # 現在の状態を管理するクラス。
  # DSLのコードはこのクラスのインスタンス上で実行される
  # dirやgroupごとにStateが作られる。
  class State
    include AssertChecker
    include ExtensionChecker
    include NameChecker

    attr_accessor :to_path,
                  :save_name,
                  :empty,
                  :additional_filename,
                  :file
    alias empty? empty

    def initialize(file)
      @file = file
      @empty = false
      @extname = @file.extname
      @name = @file.basename
      super()
    end

    def dir(dir_name, &block)
      child = dup
      begin
        child.clear File.join(@to_path, dir_name)

        child.instance_exec(@file, &block)
        raise NoGotcha if dir_name.empty?
        raise NoGotcha if child.empty?

        raise Gotcha.new(child.to_path, child.save_name)
      rescue NoGotcha
        # Ignored
      end
    end

    def group(_group_name = "", &block)
      dir("", &block)
    end

    def clear(to_path)
      @to_path = to_path
      @empty = false
    end

    def empty_dir!
      @empty = true
    end
  end
end

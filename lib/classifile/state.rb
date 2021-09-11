# frozen_string_literal: true

# Classifile
module Classifile
  ##
  # Class that manages the current state.
  # The DSL code will be executed on an instance of this class
  # A State is created for each dir and group.
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

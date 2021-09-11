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
    attr_reader :gotcha
    alias empty? empty

    def initialize(file)
      @file = file
      @empty = false
      @extname = @file.extname
      @name = @file.basename
      @gotcha = nil
      super()
    end

    def dir(dir_name, &block)
      return if @gotcha
      child = dup
      begin
        child.clear File.join(@to_path, dir_name)

        child.instance_exec(@file, &block)

        if child.gotcha
          @gotcha = child.gotcha
        else
          raise Failed if dir_name.empty?
          raise Failed if child.empty?

          @gotcha = FromTo.new(File.expand_path(@file.full_path), File.expand_path(File.join(child.to_path, child.save_name)) )
        end
      rescue Failed
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

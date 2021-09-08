# frozen_string_literal: true

# Classifile
module Classifile
  require "classifile/assert"

  # State of Classify
  class State < Assert
    attr_accessor :to_path,
                  :save_name,
                  :empty,
                  :additional_filename,
                  :file
    alias empty? empty

    def initialize(file)
      @file = file
      @empty = false
      super()
    end

    def this
      @file
    end

    def dir(dir_name, &block)
      child = dup
      begin
        child.clear File.join(@to_path, dir_name)

        child.instance_exec(@file,&block)

        raise NoGotcha if child.empty?

        gotcha = Gotcha.new(child.to_path, child.save_name)
        raise gotcha
      rescue NoGotcha
        # Ignored
      end
    end

    def group(group_name = "", &block)
      child = dup
      begin
        child.clear @to_path

        child.instance_exec(@file,&block)

        raise NoGotcha if child.empty?
      rescue NoGotcha
        # Ignored
      end
    end

    def include?(*patterns)
      patterns.each do |p|
        return if _include?(p)
      end
      raise NoGotcha
    end

    def clear(to_path)
      @to_path = to_path
      @empty = false
    end

    def empty_dir
      @empty = true
    end

    private

    def _include?(pattern)
      @file.basename.downcase.include?(pattern.downcase)
    end
  end
end

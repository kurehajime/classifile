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
                  :file,
                  :after_save_syms
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

      child = make_child dir_name
      child_run!(child, block) do
        @gotcha = MoveFile.new(File.expand_path(@file.full_path),
                               File.expand_path(File.join(child.to_path, child.save_name)))
        sets_after_save_proc(child)
      end
    end

    def group(_group_name = "", &block)
      return if @gotcha

      child = make_child ""
      child_run!(child, block) do
        # Ignored
      end
    end

    def del(&block)
      return if @gotcha

      child = make_child ""
      child_run!(child, block) do
        @gotcha = RemoveFile.new(File.expand_path(@file.full_path))
        sets_after_save_proc(child)
      end
    end

    def empty_dir!
      @empty = true
    end

    def after_save(method_name)
      @after_save_syms << method_name
    end

    private

    def child_run!(child, proc)
      child.instance_exec(@file, &proc)

      if child.gotcha
        @gotcha = child.gotcha
      else
        raise Failed if child.empty?

        yield
      end
    rescue Failed
      # Ignored
    end

    def sets_after_save_proc(child)
      child.after_save_syms.each do |sym|
        @gotcha.after_save_procs << child.method(sym)
      end
    end

    def make_child(dir_name)
      child = clone
      child.to_path = File.join(@to_path, dir_name)
      child.file.to_path = File.join(child.to_path, child.file.basename)
      child.empty = false
      child.after_save_syms = []
      child
    end
  end
end

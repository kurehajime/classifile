# frozen_string_literal: true

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
      child.to_path = File.join(@to_path, dir_name)
      child.empty = false

      child.instance_eval(&block)

      raise NoGotcha if child.empty?

      gotcha = Gotcha.new
      gotcha.path = child.to_path
      gotcha.file_name = child.save_name
      raise gotcha
    rescue NoGotcha
      # Ignored
    end
  end

  def empty_dir
    @empty = true
  end
end

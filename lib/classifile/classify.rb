# frozen_string_literal: true

# Classifile
module Classifile
  ##
  # Classify files by DSL
  class Classify
    attr_reader :file, :to_path

    def run(target_file, to_path, &block)
      raise "TypeError" unless target_file.is_a?(TargetFile)

      state = State.new(target_file)
      state.to_path = to_path
      state.save_name = target_file.basename

      begin
        state.instance_exec(state.file, &block)
      rescue NoGotcha
        # Ignored
      rescue Gotcha => e
        FromTo.new(File.expand_path(target_file.full_path), File.expand_path(File.join(e.path, e.file_name)) )
      end
    end
  end
end

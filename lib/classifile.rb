# frozen_string_literal: true

require_relative "classifile/const/version"
require_relative "classifile/const/file_types"
require_relative "classifile/error/gotcha"
require_relative "classifile/error/no_gotcha"
require_relative "classifile/checker/name_checker"
require_relative "classifile/checker/extension_checker"
require_relative "classifile/checker/assert_checker"
require_relative "classifile/io/file_tools"
require_relative "classifile/classify"
require_relative "classifile/target_file"
require_relative "classifile/state"

# Classifile
module Classifile
  # from and to
  class FromTo
    attr_accessor :from, :to

    def initialize(from, to)
      @from = from
      @to = to
    end
  end

  # execute
  class Execute
    def test(dsl_path, from_paths, to_path)
      classify(dsl_path, from_paths, to_path).each do |ft|
        puts "mv \"#{ft.from}\"  \"#{ft.to}\" "
      end
    end

    def classify(dsl_path, from_paths, to_path)
      arr = []
      dsl = FileTools.read_dsl(dsl_path)
      from_paths.each do |from_path|
        arr |= _classify(dsl, from_path, to_path)
      end

      arr
    end

    private

    def _classify(dsl, from_path, to_path)
      arr = []
      cfy = Classify.new
      FileTools.get_file_list(from_path).each do |from_file|
        result = cfy.run(TargetFile.build_by_file(from_file), File.expand_path(to_path)) do
          eval dsl # rubocop:disable all
        end
        arr << FromTo.new(from_file, File.join(result.path, result.file_name)) if result
      end

      arr
    end
  end
end

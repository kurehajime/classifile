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
    def test(dsl_path, from_path, to_path)
      run(dsl_path, from_path, to_path).each do |ft|
        puts "mv \"#{ft.from}\"  \"#{ft.to}\" "
      end
    end

    def run(dsl_path, from_path, to_path)
      arr = []
      dsl = read_dsl(dsl_path)
      cf = Classify.new
      FileTools.get_file_list(from_path).each do |from_file|
        result = cf.run(TargetFile.build_by_file(from_file), File.expand_path(to_path)) do
          eval dsl # rubocop:disable all
        end
        arr << FromTo.new(from_file, File.join(result.path, result.file_name)) if result
      end

      arr
    end

    def read_dsl(dsl_path)
      begin
        f = File.open(dsl_path)
        dsl = f.read
      ensure
        f.close
      end
      dsl
    end
  end
end

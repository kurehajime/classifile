# frozen_string_literal: true

# Classifile
module Classifile
  # execute
  class Execute
    ##
    # Classify the files by DSL.
    # However, it does not actually move the file,
    # but outputs the mv command as a string.
    def test(dsl_path, from_paths, to_path)
      classify(dsl_path, from_paths, to_path).each do |ft|
        puts "mv \"#{ft.from}\"  \"#{ft.to}\" "
      end
    end

    ##
    # Classify the files by DSL.
    def move(dsl_path, from_paths, to_path)
      classify(dsl_path, from_paths, to_path).each do |ft|
        FileTools.move(ft.from, ft.to)
        ft.after_save_procs.each(&:call)
      end
    end

    ##
    # Classify the files by DSL.
    # However, the original file will remain.
    def copy(dsl_path, from_paths, to_path)
      classify(dsl_path, from_paths, to_path).each do |ft|
        FileTools.move(ft.from, ft.to, copy: true)
        ft.after_save_procs.each(&:call)
      end
    end

    ##
    # Classify files by DSL and return an array of FromTo classes.
    def classify(dsl_path, from_paths, to_path)
      arr = []
      dsl = FileTools.read_dsl(dsl_path)
      Dir.glob(from_paths).each do |from_path|
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
        arr << result if result
      end

      arr
    end
  end
end
# frozen_string_literal: true

require_relative "classifile/version"
require_relative "classifile/const/file_types"
require_relative "classifile/error/gotcha"
require_relative "classifile/error/no_gotcha"
require_relative "classifile/checker/name_checker"
require_relative "classifile/checker/extension_checker"
require_relative "classifile/checker/assert_checker"
require_relative "classifile/file_tools"
require_relative "classifile/classify"
require_relative "classifile/target_file"
require_relative "classifile/state"

# Classifile
module Classifile
  class Error < StandardError; end
  # Your code goes here...
end

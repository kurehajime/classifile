# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "classifile"
require "classifile/error/gotcha"
require "classifile/error/no_gotcha"
require "classifile/checker/name_checker"
require "classifile/checker/extension_checker"
require "classifile/checker/assert_checker"
require "classifile/file_types"
require "classifile/file_tools"
require "classifile/classify"
require "classifile/target_file"
require "classifile/state"

require "minitest/autorun"

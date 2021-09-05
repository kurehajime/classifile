# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "classifile"
require "classifile/classify"
require "classifile/target_file"
require "classifile/state"
require "classifile/gotcha"
require "classifile/no_gotcha"

require "minitest/autorun"

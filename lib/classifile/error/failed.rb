# frozen_string_literal: true

module Classifile
  ##
  # Exception raised when a check fails.
  # Exit the dir block it is currently in.
  class Failed < StandardError
  end
end

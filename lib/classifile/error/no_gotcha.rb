# frozen_string_literal: true

module Classifile
  ##
  # チェックで不合格になった時に発生する例外
  # 現在いるdir句を抜ける。
  class NoGotcha < StandardError
  end
end

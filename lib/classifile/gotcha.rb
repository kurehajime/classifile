class Gotcha < StandardError
  attr_accessor :path, :file_name
end

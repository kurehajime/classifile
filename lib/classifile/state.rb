class State
  attr_accessor :to_path,
                :save_name,
                :empty,
                :additional_filename,
                :file
  alias_method :empty?, :empty

  def initialize(file)
    @file = file
    @empty = false
  end

  def assert(bool)
    raise NoGotcha.new unless bool
  end

  def assert_not(bool)
    raise NoGotcha.new if bool
  end

  def dir(dir_name, &block)
    child = self.dup
    begin
      child.to_path = File.join(@to_path, dir_name)
      child.empty = false

      # 子stateで評価する
      child.instance_eval(&block)

      # 子stateが保存対象外なら抜ける
      raise NoGotcha if child.empty?

      # 子Stateで保存先が見つかった
      gotcha = Gotcha.new
      gotcha.path = child.to_path
      gotcha.file_name = child.save_name
      raise gotcha
    rescue NoGotcha
      # 子Stateで保存先が見つからなかった
    end
  end

  def empty_dir()
    @empty = true
  end

end
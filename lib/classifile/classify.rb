class Classify
  attr_reader :file, :to_path

  def run(target_file, to_path, &block)
    raise "TypeError" unless target_file.is_a?(TargetFile)

    @file = target_file
    @to_path = to_path

    state = State.new(@file)
    state.to_path = @to_path
    state.save_name = @file.basename

    begin
      state.instance_eval(&block)
    rescue Gotcha => e
      return e
    rescue NoGotcha
    end

    return nil
  end
end
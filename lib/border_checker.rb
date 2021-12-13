class BorderChecker
  def initialize(lower_border, upper_border)
    @lower_border = lower_border
    @upper_border = upper_border
  end

  def check(value)
    result_value = [[value, @lower_border].max, @upper_border].min
    [result_value, value - result_value]
  end
end

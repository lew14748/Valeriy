module NumberOrNil
  def number_or_nil(string)
    num = string.to_i
    0 if num.to_s == string
  end
end

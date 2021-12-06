module StrToMethodName
  def transform(str)
    str.downcase
    str[0] = str[0].upcase
    str
  end
end

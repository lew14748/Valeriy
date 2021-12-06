require 'yaml'

class ActionLoader
  def initialize(file)
    @file = file
  end

  def load
    YAML.load_file @file
  end
end

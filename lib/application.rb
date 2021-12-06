require_relative 'states/exit'
require_relative 'states/welcome'
require_relative 'context'
require_relative 'action_loader'

class Application

  def run
    actions = ActionLoader.new('actions.yml').load
    context = Context.new AppStates::Welcome.new
  end

end

require_relative 'states/exit'
require_relative 'states/welcome'
require_relative 'context'
require_relative 'action_loader'
require_relative 'valera'
require_relative 'action'

class Application
  def run
    actions = ActionLoader.new('actions.yml').load
    # valera = Valera.new money: 20
    # Action.new(actions[0], valera).do_action
    context = Context.new AppStates::Welcome.new
  end
end

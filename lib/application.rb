require_relative 'states/exit'
require_relative 'states/welcome'
require_relative 'context'
require_relative 'action_loader'

class Application
  def run
    context = Context.new.transition_to_state(AppStates::Welcome.new)
    loop do
      context.state.run
    end
  end
end

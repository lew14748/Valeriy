require_relative 'states/exit'  
require_relative 'states/welcome'
require_relative 'states/base_state'

class Context

    def initialize  (state)
        transition_to_state state
    end

    def repeat_state
        @state.run
    end

    def transition_to_state (state)
        @state = state
        @state.context = self
        @state.run
    end
    
end
module AppStates
  class Play < BaseState
    def run
      render
      # interact with player unless valerio is dead
      context.transition_to_state AppStates::Welcome.new
    end

    def render
      io_adapter.clear
      io_adapter.write 'you are in playing state'
    end
  end
end

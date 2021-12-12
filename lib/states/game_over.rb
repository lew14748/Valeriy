module AppStates
  class GameOver < BaseState
    def render
      io_adapter.clear
      io_adapter.write 'You lose'
      sleep 1
    end

    def run
      render
      Context.new AppStates::Welcome.new
    end
  end
end

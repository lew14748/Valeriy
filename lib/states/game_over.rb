module AppStates
  class GameOver < BaseState
    def render
      io_adapter.clear
      io_adapter.write 'You lose'
      io_adapter.write '---' * 14
    end

    def run
      render
      Context.new AppStates::Welcome.new
    end
  end
end

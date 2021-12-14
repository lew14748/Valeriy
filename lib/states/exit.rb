require_relative '../io_adapter'
require_relative 'base_state'
module AppStates
  class Exit < BaseState
    def render
      io_adapter.clear
      io_adapter.write 'Bye, have a beautiful time!!'
    end

    def run
      render
      exit 0
    end
  end
end

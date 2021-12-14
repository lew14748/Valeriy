require_relative '../io_adapter'

module AppStates
  class BaseState
    attr_accessor :context, :error

    def render; end

    def io_adapter
      IOAdapter.instance
    end

    def change_state; end

    def run; end
  end
end

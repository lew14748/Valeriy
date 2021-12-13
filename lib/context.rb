require_relative 'states/exit'
require_relative 'states/welcome'
require_relative 'states/base_state'
require_relative 'valera'
require_relative 'action'

class Context
  attr_accessor :valera, :actions

  def initialize(state)
    @valera = Valera.new
    @actions = ActionLoader.new('actions.yml').load
    transition_to_state state
  end

  def repeat_state
    @state.run
  end

  def go_to_prev_state
    buf = @state
    @state = @prev_state
    @prev_state = @state
    @state.run
  end

  def transition_to_state(state)
    @prev_state = @state
    @state = state
    @state.context = self
    @state.run
  end
end

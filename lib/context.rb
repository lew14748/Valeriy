require_relative 'states/exit'
require_relative 'states/welcome'
require_relative 'states/base_state'
require_relative 'valera'
require_relative 'action'
require_relative 'action_loader'

class Context
  attr_accessor :valera, :actions, :state

  def initialize
    @valera = Valera.new
    @actions = ActionLoader.new('actions.yml').load
  end

  def repeat_state
    @state.run
  end

  def go_to_prev_state
    @state, @prev_state = @prev_state, @state
    @state.run
  end

  def transition_to_state(state)
    @prev_state = @state
    @state = state
    @state.context = self
  end
end

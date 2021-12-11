require_relative 'base_state'
require_relative 'play'
require_relative 'load'
require_relative '../menu'
require_relative 'exit'
require_relative '../context'
require_relative '../modules/str_to_method_name'
require_relative '../loader'
require_relative '../valera'
require_relative '../action'

module AppStates
  class Welcome < BaseState
    attr_accessor :start_menu, :utils_menu

    def render
      io_adapter.write 'incredible life of somebody called Valeriy'
      start_menu.render_vertical
      io_adapter.write '---' * 14
      utils_menu.render_horizontal
      # Action.new(@context.actions[1], @context.valera).do_action
    end

    def run
      render
      change_state
    end

    def change_state
      send check_user_input
    end

    def exit
      @context.transition_to_state(AppStates::Exit.new)
    end

    def play
      io_adapter.write 'here must be game i guess'
      @context.transition_to_state(AppStates::Play.new)
    end

    def load
      @context.transition_to_state(AppStates::Load.new)
    end

    def wrong_state
      # io_adapter.clear
      io_adapter.write 'Try choosing correct options!!'
      @context.repeat_state
    end

    def start_menu
      @start_menu ||= Menu.new
      @start_menu.initialise_custom_menu [
        { title: 'Play', command: '1', action: :play },
        { title: 'Load', command: '2', action: :load }
      ]
      @start_menu
    end

    def check_user_input
      input = io_adapter.read
      input.downcase
      state1 = @utils_menu.handle_main_menu_input(input)
      state2 = @start_menu.handle_game_menu_input(input)
      if !state1.nil?
        state1
      elsif !state2.nil?
        state2
      else
        :wrong_state
      end
    end

    def utils_menu
      @utils_menu ||= Menu.new
      @utils_menu.initialise_custom_main_menu :exit
      @utils_menu
    end
  end
end

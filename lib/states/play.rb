require_relative '../action'
require_relative 'save'
require_relative 'exit'
require_relative 'load'
require_relative 'game_over'

module AppStates
  class Play < BaseState
    def run
      until @context.valera.dead?
        render
        action = check_user_input
        private_methods.include?(action) ? send(action) : action(action)
      end
      @context.transition_to_state(AppStates::GameOver.new)
    end

    def render
      io_adapter.clear
      io_adapter.write 'You are in playing state'
      render_valera
      actions_menu.render_vertical
      io_adapter.write '---' * 14
      utils_menu.render_horizontal
    end

    def render_valera
      io_adapter.write '---' * 14
      io_adapter.write 'Valera stats:'
      show_money
      show_health
      show_mana
      show_fun
      show_fatigue
      io_adapter.write '---' * 14
    end

    def show_money
      io_adapter.write "Money: #{@context.valera.money}"
    end

    def show_health
      io_adapter.write "Health: #{@context.valera.health}"
    end

    def show_mana
      io_adapter.write "Mana: #{@context.valera.mana}"
    end

    def show_fun
      io_adapter.write "Fun: #{@context.valera.fun}"
    end

    def show_fatigue
      io_adapter.write "Fatigue: #{@context.valera.fatigue}"
    end

    def actions_menu
      @actions_menu ||= Menu.new
      @menu = Array.new(@context.actions.size) { {} }
      @actions_menu.initialise_custom_menu(fill_menu_by_actions)
      @actions_menu
    end

    def fill_menu_by_actions
      serial_number = 1
      (0...@menu.size).each do |i|
        next unless conds_correct?(i)

        add_in_menu(i, serial_number)
        serial_number += 1
      end
      @menu.reject!(&:empty?)
      @menu
    end

    def conds_correct?(number)
      Action.new(@context.actions[number], @context.valera).conds_correct?
    end

    def add_in_menu(action_number, serial_number)
      @menu[serial_number - 1][:title] = (@context.actions[action_number]['before_text']).to_s
      @menu[serial_number - 1][:command] = serial_number.to_s
      @menu[serial_number - 1][:action] = action_number
    end

    def check_user_input
      input = io_adapter.read
      @utils_menu.handle_main_menu_input(input) || @actions_menu.handle_game_menu_input(input) || :wrong_state
    end

    def utils_menu
      @utils_menu ||= Menu.new
      @utils_menu.initialise_main_menu
      @utils_menu
    end

    def action(number)
      io_adapter.write @context.actions[number]['after_text']
      sleep 1
      Action.new(@context.actions[number], @context.valera).do_action
    end

    private

    def load
      @context.transition_to_state(AppStates::Load.new)
      @context.state.run
    end

    def save
      @context.transition_to_state(AppStates::Save.new)
      @context.state.run
    end

    def exit
      @context.transition_to_state(AppStates::Exit.new)
      @context.state.run
    end

    def wrong_state
      io_adapter.write 'Try choosing correct options!!'
      sleep 0.5
    end
  end
end

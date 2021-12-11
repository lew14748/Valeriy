require_relative '../action'
require_relative 'save'
require_relative 'exit'
require_relative 'load'

module AppStates
  class Play < BaseState
    def run
      until @context.valera.dead? do
        render
        action = check_user_input
        private_methods.include?(action) ? send(action) : action(action)
      end
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
      io_adapter.write "Money = #{@context.valera.money}"
      io_adapter.write "Health = #{@context.valera.health}"
      io_adapter.write "Mana = #{@context.valera.mana}"
      io_adapter.write "Fun = #{@context.valera.fun}"
      io_adapter.write "Fatigue = #{@context.valera.fatigue}"
      io_adapter.write '---' * 14
    end

    def actions_menu
      menu = Array.new(@context.actions.size) { Hash.new }
      menu.each_with_index { |action, i| 
        # conds_correct?
        menu[i][:title] = "#{@context.actions[i]['before_text']}"
        menu[i][:command] = "#{i + 1}"
        menu[i][:action] = i
      }
      @actions_menu ||= Menu.new
      @actions_menu.initialise_custom_menu menu
      @actions_menu
    end

    def check_user_input
      input = io_adapter.read
      input.downcase
      action = @utils_menu.handle_main_menu_input(input) || @actions_menu.handle_game_menu_input(input) || :wrong_state
    end

    def utils_menu
      @utils_menu ||= Menu.new
      @utils_menu.initialise_main_menu
      @utils_menu
    end

    def action number
      io_adapter.write @context.actions[number]['after_text']
      sleep 1
      Action.new(@context.actions[number], @context.valera).do_action
    end

    private
    def load
      io_adapter.write 'You are in loading state'
      @context.transition_to_state(AppStates::Load.new)
    end

    def save
      io_adapter.write 'You are in saving state'
      @context.transition_to_state(AppStates::Save.new)
    end

    def exit
      @context.transition_to_state(AppStates::Exit.new)
    end

    def wrong_state
      io_adapter.write 'Try choosing correct options!!'
      sleep 0.5
      @context.repeat_state
    end
  end
end

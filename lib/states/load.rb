require_relative 'base_state'
require_relative '../loader'
require_relative '../menu'
module AppStates
  class Load < BaseState
    def run
      render
      utils_menu.render_horizontal
      input = io_adapter.read
      utils_action = utils_menu.handle_main_menu_input(input)
      return send(utils_action) if utils_action

      choice = @load_process.take_number_of_save input
      if choice != 0 && !File.zero?("saves/save#{choice}.yml")
        load_valera_to_game(choice)
      else
        send :wrong_state
      end
    end

    def render
      io_adapter.clear
      io_adapter.write '=== CHOOSE YOUR SAVE ==='
      load_process
    end

    def load_process
      @load_process = Loader.new

      @load_process.find_save_folder
      @load_process.find_saves
      @load_process
    end

    def give_stats_to_valera(valera)
      give_money_to_valera(valera)
      give_fun_to_valera(valera)
      give_health_to_valera(valera)
      give_fatigue_to_valera(valera)
      give_mana_to_valera(valera)
    end

    def give_money_to_valera(valera)
      @context.valera.money = valera[valera.size - 1]['money']
    end

    def give_fun_to_valera(valera)
      @context.valera.fun = valera[valera.size - 1]['fun']
    end

    def give_health_to_valera(valera)
      @context.valera.health = valera[valera.size - 1]['health']
    end

    def give_fatigue_to_valera(valera)
      @context.valera.fatigue = valera[valera.size - 1]['fatigue']
    end

    def give_mana_to_valera(valera)
      @context.valera.mana = valera[valera.size - 1]['mana']
    end

    def utils_menu
      @utils_menu ||= Menu.new
      @utils_menu.initialise_custom_menu [
        { title: 'Back', command: 'back', action: :back },
        { title: 'Exit', command: 'exit', action: :exit }
      ]
      @utils_menu
    end

    private

    def exit
      @context.transition_to_state(AppStates::Exit.new)
    end

    def load
      @context.transition_to_state(AppStates::Load.new)
    end

    def back
      @context.go_to_prev_state
    end

    def wrong_state
      io_adapter.write 'Try choosing correct options!!'
      sleep 1
    end

    def load_valera_to_game(choice)
      valera = @load_process.load_save(choice)
      give_stats_to_valera(valera) unless valera.nil?
      @context.transition_to_state(AppStates::Play.new)
    end
  end
end

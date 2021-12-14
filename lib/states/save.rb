require_relative 'base_state'
require_relative '../saver'
module AppStates
  class Save < BaseState
    def run
      io_adapter.clear
      @save_process = Saver.new
      @save_process.check_save_folder
      @save_process.find_saves
      utils_menu.render_horizontal

      input = io_adapter.read
      utils_action = utils_menu.handle_main_menu_input(input)
      return send(utils_action) if utils_action

      choice = @save_process.take_number_of_save input
      choice.zero? ? send(:wrong_state) : save_and_go_back(choice)
    end

    def save_and_go_back(choice)
      @save_process.save_to_file(@context.valera, choice)
      back
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

    def back
      @context.go_to_prev_state
    end

    def wrong_state
      io_adapter.write 'Try choosing correct options!!'
      sleep 1
    end
  end
end

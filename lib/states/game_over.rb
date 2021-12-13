module AppStates
  class GameOver < BaseState
    def render
      io_adapter.clear
      io_adapter.write 'You lose'
      sleep 1
      io_adapter.write 'CHOOSE YOUR DESTINY'
      utils_menu.render_horizontal
      input = io_adapter.read
      utils_action = utils_menu.handle_main_menu_input input
      utils_action ? send(utils_action) : send(:wrong_state)
    end

    def run
      render
      Context.new AppStates::Welcome.new
    end

    def utils_menu
      @utils_menu ||= Menu.new
      @utils_menu.initialise_custom_menu [
        { title: 'Back to start menu', command: 'back', action: :back },
        { title: 'Exit', command: 'exit', action: :load }
      ]
      @utils_menu
    end

    def exit
      @context.transition_to_state(AppStates::Exit.new)
    end

    def wrong_state
      # io_adapter.clear
      io_adapter.write 'Try choosing correct options!!'
      sleep 1
      @context.repeat_state
    end
  end
end

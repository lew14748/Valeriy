require_relative 'base_state'
require_relative '../loader'
module AppStates
  class Load < BaseState
    def run
      load_process = Loader.new
      render
      load_process.find_save_folder
      context.transition_to_state AppStates::Welcome.new if load_process.find_saves.nil?
      # choose at menu
      # go to welcome
      # choose save
      load_process.load_save load_process.take_number_of_save
      context.transition_to_state AppStates::Welcome.new
    end

    def render
      io_adapter.write '=== CHOOSE YOUR SAVE ==='
    end
  end
end

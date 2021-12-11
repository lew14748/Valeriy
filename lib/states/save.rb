require_relative 'base_state'
require_relative '../saver'
module AppStates
  class Save < BaseState
    def run
      save_process = Saver.new
      save_process.find_save_folder
      save_process.find_saves
      # if find saves = nil then MENU create new or go back to the game
      # continue game
      save_process.take_number_of_save
      context.transition_to_state AppStates::Welcome.new # change to play
    end
  end
end

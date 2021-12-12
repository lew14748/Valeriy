require_relative 'base_state'
require_relative '../saver'
module AppStates
  class Save < BaseState
    def run
      io_adapter.clear
      save_process = Saver.new
      save_process.check_save_folder
      save_process.find_saves
      choice = save_process.take_number_of_save
      save_process.save_to_file(@context.valera, choice) if choice != 0
    end
  end
end

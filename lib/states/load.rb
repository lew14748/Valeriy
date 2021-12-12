require_relative 'base_state'
require_relative '../loader'
module AppStates
  class Load < BaseState
    def run
      render
      load_process = Loader.new
      load_process.find_save_folder
      load_process.find_saves
      choice = load_process.take_number_of_save
      if (choice != 0)  
        valera = load_process.load_save(choice) 
        give_stats_to_valera(valera) if (valera != nil)
        @context.transition_to_state(AppStates::Play.new)
      else
        @context.transition_to_state(AppStates::Welcome.new)
      end
    end

    def render
      io_adapter.clear
      io_adapter.write '=== CHOOSE YOUR SAVE ==='
    end

    def give_stats_to_valera valera
      @context.valera.money = valera[valera.size - 1]['money']
      @context.valera.fun = valera[valera.size - 1]['fun']
      @context.valera.health = valera[valera.size - 1]['health']
      @context.valera.fatigue = valera[valera.size - 1]['fatigue']
      @context.valera.mana = valera[valera.size - 1]['mana']
    end
  end
end

require_relative 'base_state'
module AppStates
  class Load < BaseState
    def run
      find_save_folder
      load_save get_number_of_save
      context.transition_to_state AppStates::Welcome.new
    end

    def load_save(save_number)
      @load_file = @saves[save_number]
      #insert to valera stats from file
    end

    def get_number_of_save
      num = io_adapter.read
      num if valid? num
    end

    def valid?(number)
      return true if (number.to_i.is_a? Integer) && number.to_i <= @saves_count && number.to_i >= 1

      false
    end

    def render
      io_adapter.write '=== CHOOSE YOUR SAVE ==='
      find_save_folder
    end

    def find_save_folder
      if File.directory?('saves')
        find_saves
      else
        Dir.mkdir('saves')
      end
    end

    def find_saves
      @saves = Dir.glob('saves/*.yml')
      if @saves.any?
        show_saves
      else
        io_adapter.write 'You have not any saves'
        context.transition_to_state AppStates::Welcome.new
      end
    end

    def show_saves
      @saves_count = 0
      @saves.each do |save|
        @saves_count += 1
        puts "#{@saves_count} - #{save}"
      end
    end
  end
end

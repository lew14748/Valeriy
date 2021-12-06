module AppStates
    class Load < BaseState
        def run
            find_save_folder
            context.transition_to_state AppStates::Welcome.new
        end

        def find_save_folder
            if File.directory?("saves")
                find_saves
            else
                Dir.mkdir("saves")
            end
        end

        def find_saves
            @saves = Dir.glob("saves/*.yml")
            if @saves.any?
                io_adapter.write 'Choose your save'
                show_saves @saves
            else
                io_adapter.write 'You have not any saves'
                context.transition_to_state AppStates::Welcome.new
            end
        end

        def show_saves saves
            num = 0
            for save in saves do 
                num = num + 1
                io_adapter.write "[#{num}]#{save}"
            end
        end
    end
end
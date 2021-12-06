module AppStates
    class Load < BaseState
        def run
            render
            #save
            context.transition_to_state AppStates::Welcome.new
        end

        def render
          io_adapter.clear
          io_adapter.write 'you are in loading state'
        end
    end
end
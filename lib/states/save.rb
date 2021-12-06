module AppStates
    class Save < BaseState
        def run
            find_save_folder
            #continue game
        end

        def find_save_folder
            if !File.directory?("saves")
                Dir.mkdir("saves")
            end
            find_saves
        end

        def find_saves
            @saves = Dir.glob("saves/*.yml")
            if @saves.any?
                io_adapter.write 'You can rewrite your save or create new'
                show_saves
            else
                io_adapter.write 'You have not any saves, you can make new one'    
            end
        end

        def show_saves saves
            io_adapter.write 'Your saves: '
            num = 0
            for save in saves do 
                num = num + 1
                io_adapter.write "[#{num}]#{save}"
            end
        end

        def saver Valera
            @save_content = 
"Valera:
  -
    health = #{Valera.health}
    mana = #{Valera.mana}
    fun = #{Valera.fun}
    money = #{Valera.money}
    fatigue = #{Valera.fatigue}"
            File.open('saves/save1.yml', "w") { |file| file.write(@save_content) }

        end

    end
end
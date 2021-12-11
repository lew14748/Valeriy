require_relative './io_adapter'

class Saver
  def find_save_folder
    Dir.mkdir('saves') unless File.directory?('saves')
  end

  def find_saves
    @saves = Dir.glob('saves/*.yml')
    if @saves.any?
      io_adapter.write 'You can rewrite your save or create new'
      show_saves @saves
    else
      io_adapter.write 'You have not any saves, you can create new one'
      nil
    end
  end

  def show_saves(_saves)
    @saves_count = 0
    @saves.each do |save|
      @saves_count += 1
      puts "#{@saves_count} - #{save}"
    end
  end

  def saver(valera, name_of_save)
    @save_content =
      "Valera:
-
health = #{valera.health}
mana = #{valera.mana}
fun = #{valera.fun}
money = #{valera.money}
fatigue = #{valera.fatigue}"
    File.open("saves/#{name_of_save}.yml", 'w') { |file| file.write(@save_content) }
  end

  def io_adapter
    IOAdapter.instance
  end

  def take_number_of_save
    num = io_adapter.read
    valid?(num) ? (num.to_i - 1) : 0
  end

  def valid?(number)
    return true if (number.to_i.is_a? Integer) && number.to_i <= @saves_count && number.to_i >= 1

    false
  end
end

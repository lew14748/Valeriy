require_relative './io_adapter'

class Saver
  def check_save_folder
    Dir.mkdir('saves') unless File.directory?('saves')
  end

  def find_saves
    @saves = Dir.glob('saves/*.yml')
    if @saves.any?
      io_adapter.write 'Choose slot for saving'
    else
      (1..9).each do |i|
        File.open("saves/save#{i}.yml", 'w') { |file| file.write('') }
      end
    end
    show_saves
  end

  def show_saves
    (1..9).each do |i|
      if File.zero?("saves/save#{i}.yml")
        io_adapter.write("[#{i}] Save #{i} - Empty")
      else
        io_adapter.write("[#{i}] Save #{i} - Used")
      end
    end
  end

  def save_to_file(valera, number_of_save)
    @save_content =
      "-
  health: #{valera.health}
  mana: #{valera.mana}
  fun: #{valera.fun}
  money: #{valera.money}
  fatigue: #{valera.fatigue}"
    File.open("saves/save#{number_of_save}.yml", 'w') { |file| file.write(@save_content) }
  end

  def io_adapter
    IOAdapter.instance
  end

  def take_number_of_save(num)
    valid?(num) ? num.to_i : 0
  end

  def valid?(number)
    return true if (number.to_i.is_a? Integer) && number.to_i <= 9 && number.to_i >= 1

    false
  end
end

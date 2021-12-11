require_relative './io_adapter'
require_relative './states/base_state'
require_relative './context'
class Loader
  def find_save_folder
    if !File.directory?('saves')
      Dir.mkdir('saves')
    end
  end

  def find_saves
    @saves = Dir.glob('saves/*.yml')
    if @saves.any?
      show_saves
    else
      io_adapter.write 'You have not any saves'
      nil
    end
  end

  def show_saves
    @saves_count = 0
    @saves.each do |save|
      @saves_count += 1
      puts "#{@saves_count} - #{save}"
    end
  end

  def load_save(save_number)
    @load_file = @saves[save_number]
    #insert to valera stats from file
  end

  def take_number_of_save
    num = io_adapter.read
    (valid? (num)) ? (num.to_i - 1) : 0
  end

  def valid?(number)
    return true if (number.to_i.is_a? Integer) && number.to_i <= @saves_count && number.to_i >= 1

    false
  end

  def io_adapter
    IOAdapter.instance
  end
end

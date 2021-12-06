require_relative './io_adapter'
class Menu
  MAIN_MENU_OPTIONS = [
    { title: 'Save', command: 'save', action: :save },
    { title: 'Load', command: 'load', action: :load },
    { title: 'Exit', command: 'exit', action: :exit }
  ].freeze

  def initialise_custom_menu(menu_rows)
    @menu_rows = menu_rows
  end

  def initialise_custom_main_menu(row)
    options = MAIN_MENU_OPTIONS.clone
    @menu_rows = options.find { |option| row.to_s.include? option[:action].to_s }
  end

  def initialise_main_menu
    @menu_rows = MAIN_MENU_OPTIONS.clone
    @menu_rows
  end

  def render_exit_menu
    io_adapter.write '|' + @menu_rows[:title] + '[' + @menu_rows[:command] + ']|'
  end

  def render_horizontal
    row = '|'
    @menu_rows.each { |item| row += "#{item[:title]} [#{item[:command]}]|" }
    io_adapter.write row
  end

  def render_vertical
    @menu_rows.each_with_index { |menu_row, _i| io_adapter.write "[#{menu_row[:command]}]#{menu_row[:title]}" }
  end

  def number_or_nil(string)
    num = string.to_i
    0 if num.to_s == string
  end

  def handle_start_menu_input; end

  def handle_main_menu_input(input)
    option = nil
    puts @menu_row
    if @menu_rows.is_a?(Array)
      options = @menu_rows.select { |option| option[:action] }
      option = options.find { |option| option == input }
      puts 'rows'
      option
    elsif return @menu_rows[:action].to_s if input.to_s == @menu_rows[:action].to_s

      nil
    end
  end

  def handle_game_menu_input(number)
    return nil if (number.to_i) > 2 || (number.to_i) < 1 || number_or_nil(number.to_i) == 0

    option = @menu_rows.find { |menu_row| menu_row[:command] == number }
    option[:action]
  end

  def io_adapter
    IOAdapter.instance
  end
end

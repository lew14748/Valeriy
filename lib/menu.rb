require_relative './io_adapter'
require_relative './modules/number_or_nil'

class Menu
  attr_accessor :menu_rows

  include NumberOrNil
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
    @menu_rows = options.select { |option| row == option[:action] }
  end

  def initialise_main_menu
    @menu_rows = MAIN_MENU_OPTIONS.clone
    @menu_rows
  end

  def render_horizontal
    row = '|'
    @menu_rows.each { |item| row += "#{item[:title]} [#{item[:command]}]|" }
    io_adapter.write row
  end

  def render_vertical
    @menu_rows.each_with_index { |menu_row, _i| io_adapter.write "[#{menu_row[:command]}]#{menu_row[:title]}" }
  end

  def handle_start_menu_input; end

  def handle_main_menu_input(input)
    option = @menu_rows.find { |row| row[:command].to_s == input }
    option.nil? ? nil : option[:action]
  end

  def handle_game_menu_input(number)
    return nil if number_or_nil(number.to_i) || !number.to_i.between?(1, @menu_rows.size)

    option = @menu_rows.find { |menu_row| menu_row[:command].to_s == number.to_s }
    option[:action]
  end

  def io_adapter
    IOAdapter.instance
  end
end

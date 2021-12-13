require_relative '../../lib/states/play'
require_relative '../../lib/states/base_state'
require_relative '../../lib/valera'
require_relative '../../lib/context'
require_relative '../../lib/action_loader'

RSpec.describe AppStates::Play do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
    allow(io_mock).to receive(:clear)
  end

  let(:state) { AppStates::Play.new }
  let(:context) { Context.new }

  describe '#show_money' do
    it 'correct show money of Valera' do
      state.context = Context.new
      state.show_money
      expect(io_mock).to have_received(:write).with(
        "Money: #{context.valera.money}"
      )
    end
  end

  describe '#show_health' do
    it 'correct show health of Valera' do
      state.context = Context.new
      state.show_health
      expect(io_mock).to have_received(:write).with(
        "Health: #{context.valera.health}"
      )
    end
  end

  describe '#show_mana' do
    it 'correct show mana of Valera' do
      state.context = Context.new
      state.show_mana
      expect(io_mock).to have_received(:write).with(
        "Mana: #{context.valera.mana}"
      )
    end
  end

  describe '#show_fun' do
    it 'correct show fun of Valera' do
      state.context = Context.new
      state.show_fun
      expect(io_mock).to have_received(:write).with(
        "Fun: #{context.valera.fun}"
      )
    end
  end

  describe '#show_fatigue' do
    it 'correct show fatigue of Valera' do
      state.context = Context.new
      state.show_fatigue
      expect(io_mock).to have_received(:write).with(
        "Fatigue: #{context.valera.fatigue}"
      )
    end
  end

  describe '#render_valera' do
    it 'correct render Valera' do
      state.context = Context.new
      state.render_valera
      expect(io_mock).to have_received(:write).with(
        '---' * 14
      ).twice
      expect(io_mock).to have_received(:write).with(
        'Valera stats:'
      )
      expect(io_mock).to have_received(:write).with(
        "Money: #{context.valera.money}"
      )
      expect(io_mock).to have_received(:write).with(
        "Health: #{context.valera.health}"
      )
      expect(io_mock).to have_received(:write).with(
        "Mana: #{context.valera.mana}"
      )
      expect(io_mock).to have_received(:write).with(
        "Fun: #{context.valera.fun}"
      )
      expect(io_mock).to have_received(:write).with(
        "Fatigue: #{context.valera.fatigue}"
      )
    end
  end

  describe '#render' do
    it 'correct render' do
      state.context = Context.new
      state.render
      expect(io_mock).to have_received(:write).with(
        'You are in playing state'
      )
      expect(io_mock).to have_received(:write).with(
        '---' * 14
      ).exactly(3).times
      expect(io_mock).to have_received(:write).with(
        'Valera stats:'
      )
      expect(io_mock).to have_received(:write).with(
        "Money: #{context.valera.money}"
      )
      expect(io_mock).to have_received(:write).with(
        "Health: #{context.valera.health}"
      )
      expect(io_mock).to have_received(:write).with(
        "Mana: #{context.valera.mana}"
      )
      expect(io_mock).to have_received(:write).with(
        "Fun: #{context.valera.fun}"
      )
      expect(io_mock).to have_received(:write).with(
        "Fatigue: #{context.valera.fatigue}"
      )
      expect(io_mock).to have_received(:write).with(
        '[1]Working'
      )
      expect(io_mock).to have_received(:write).with(
        '[2]Reading a book'
      )
      expect(io_mock).to have_received(:write).with(
        '[3]To meet friends'
      )
      expect(io_mock).to have_received(:write).with(
        '|Save [save]|Load [load]|Exit [exit]|'
      )
    end
  end

  describe '#fill_menu_by_actions' do
    let(:menu) { state.fill_menu_by_actions }
    let(:correct_menu) do
      [{ action: 1, command: '1', title: 'Working' },
       { action: 8, command: '2', title: 'Reading a book' },
       { action: 9, command: '3', title: 'To meet friends' }]
    end

    it 'correct filling of the array' do
      state.context = Context.new
      state.actions_menu
      expect(menu).to eq correct_menu
    end
  end

  describe '#action_menu' do
    let(:menu) { state.actions_menu }
    it 'correct initialise custom menu' do
      state.context = Context.new
      state.actions_menu
      expect(menu).to eq state.actions_menu
    end
  end

  describe '#conds_correct?' do
    context 'checks if the conditions for an action pass' do
      it 'incorrect conds' do
        state.context = Context.new
        expect(state.conds_correct?(0)).to eq false
      end

      it 'correct conds' do
        state.context = Context.new
        expect(state.conds_correct?(1)).to eq true
      end
    end
  end

  describe '#add_in_menu' do
    let(:menu) { state.fill_menu_by_actions }
    let(:correct_menu) do
      [{ action: 1, command: '1', title: 'Working' },
       { action: 8, command: '2', title: 'Reading a book' },
       { action: 9, command: '3', title: 'To meet friends' }]
    end

    it 'correct addition to array' do
      state.context = Context.new
      state.actions_menu
      expect(menu).to eq correct_menu
    end
  end

  describe '#check_user_input' do
    subject { state.check_user_input }

    before do
      state.context = Context.new
      state.actions_menu
      state.utils_menu
    end

    context 'when user input "exit"' do
      before { allow(io_mock).to receive(:read).and_return('exit') }
      it { is_expected.to eq :exit }
    end

    context 'when user input "load"' do
      before { allow(io_mock).to receive(:read).and_return('load') }
      it { is_expected.to eq :load }
    end

    context 'when user input "save"' do
      before { allow(io_mock).to receive(:read).and_return('save') }
      it { is_expected.to eq :save }
    end

    context 'when user input "1"' do
      before { allow(io_mock).to receive(:read).and_return('1') }
      it { is_expected.to eq 1 }
    end

    context 'when user input "2"' do
      before { allow(io_mock).to receive(:read).and_return('2') }
      it { is_expected.to eq 8 }
    end

    context 'when user input "3"' do
      before { allow(io_mock).to receive(:read).and_return('3') }
      it { is_expected.to eq 9 }
    end

    context 'when user input "fake"' do
      before { allow(io_mock).to receive(:read).and_return('fake') }
      it { is_expected.to eq :wrong_state }
    end
  end

  describe '#utils_menu' do
    let(:menu) { state.utils_menu }
    it 'correct initialise utils menu' do
      state.context = Context.new
      state.actions_menu
      expect(menu).to eq state.utils_menu
    end
  end

  describe '#action' do
    it 'executing an action' do
      state.context = Context.new
      state.action(1)
      expect(io_mock).to have_received(:write).with(
        'Office work is not for Valery'
      )
    end
  end
end

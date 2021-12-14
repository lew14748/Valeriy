require_relative '../../lib/action_loader'
require_relative '../../lib/context'
require_relative '../../lib/loader'
require_relative '../../lib/states/welcome'
require_relative '../../lib/states/exit'
require_relative '../../lib/states/play'
require_relative '../../lib/states/load'
require './lib/io_adapter'

describe AppStates::Load do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:read)
    allow(io_mock).to receive(:clear)
    allow(io_mock).to receive(:write)
  end
  let(:state) { AppStates::Load.new }
  let(:load_state) { AppStates::Load.new }
  let(:context) { Context.new }

  describe '#render' do
    it 'renders text about choosing save' do
      load_state.render
      expect(io_mock).to have_received(:write).with(
        '=== CHOOSE YOUR SAVE ==='
      )
    end
  end

  describe '#give_stats_to_valera' do
    it 'giving stats Valere' do
      state.context = Context.new
      valera = Loader.new.load_save(9)
      state.give_stats_to_valera(valera)
      expect(context.valera.money).to eq 0
      expect(context.valera.mana).to eq 0
      expect(context.valera.fun).to eq 0
      expect(context.valera.fatigue).to eq 0
      expect(context.valera.health).to eq 100
    end
  end

  describe '#utils_menu' do
    it 'creates menu' do
      loadd = AppStates::Load.new
      var = loadd.utils_menu.menu_rows
      expect(var).to eq [
        { title: 'Back', command: 'back', action: :back },
        { title: 'Exit', command: 'exit', action: :exit }
      ]
    end
  end

  describe '#run' do
    context 'when user inputs "10"' do
      before do
        @load_state = AppStates::Load.new
        @context = Context.new.transition_to_state @load_state

        @context.state = @load_state
        @context.state.run
        allow(io_mock).to receive(:read).and_return('10')
      end
      it 'repeats state' do
        expect(@context.state).to be_a AppStates::Load
      end
    end
  end
end

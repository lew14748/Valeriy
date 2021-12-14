require_relative '../../lib/action_loader'
require_relative '../../lib/context'
require_relative '../../lib/loader'
require_relative '../../lib/states/welcome'
require_relative '../../lib/states/base_state'
require_relative '../../lib/states/play'
require_relative '../../lib/states/save'
require './lib/io_adapter'

describe AppStates::Load do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:read)
    allow(io_mock).to receive(:clear)
    allow(io_mock).to receive(:write)
  end
  let(:state) { AppStates::Save.new }
  let(:context) { Context.new }

  describe '#utils_menu' do
    it 'creates menu' do
      var = state.utils_menu.menu_rows
      expect(var).to eq [
        { title: 'Back', command: 'back', action: :back },
        { title: 'Exit', command: 'exit', action: :exit }
      ]
    end
  end

  describe '#run' do
    context 'when user inputs "10"' do
      before do
        @save_state = AppStates::Save.new
        @context = Context.new.transition_to_state @save_state

        @context.state = @save_state
        @context.state.run
        allow(io_mock).to receive(:read).and_return('10')
      end
      it 'repeats state' do
        expect(@context.state).to be_a AppStates::Save
      end
    end
  end
end

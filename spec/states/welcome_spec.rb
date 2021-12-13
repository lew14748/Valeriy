require_relative '../../lib/action_loader'
require_relative '../../lib/context'
require_relative '../../lib/states/welcome'
require_relative '../../lib/states/exit'
require_relative '../../lib/states/play'
require_relative '../../lib/states/load'
require './lib/io_adapter'

describe AppStates::Welcome do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:read)
    allow(io_mock).to receive(:clear)
    allow(io_mock).to receive(:write)
  end
  state = AppStates::Welcome.new
  let(:welcome_state) { AppStates::Welcome.new }
  let(:context) { Context.new.transition_to_state AppStates::Welcome }
  describe '#render' do
    it 'renders correct start menu' do
      welcome_state.render
      expect(io_mock).to have_received(:write).with(
        'incredible life of somebody called Valeriy'
      )
      expect(io_mock).to have_received(:write).with(
        '[1]Play'
      )
      expect(io_mock).to have_received(:write).with(
        '[2]Load'
      )
      expect(io_mock).to have_received(:write).with(
        '---' * 14
      )
      expect(io_mock).to have_received(:write).with(
        '|Exit [exit]|'
      )
    end
  end

  describe '#play' do
    subject {context.state}
    before do
      context.state.run
    end
    context 'user wanna play and presses "1"' do
      before { allow(io_mock).to receive(:read).and_return('1') }
      it { is_expected.to be_a AppStates::Play}
    end
  end
end

# describe '#next' do
# subject { state.next }
# context 'when user inputs "1"' do
#   before { allow(io_mock).to receive(:read).and_return('1') }
#   it { is_expected.to be_a AppStates::Play }
# end

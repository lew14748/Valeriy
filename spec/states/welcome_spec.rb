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

  describe '#check_user_input' do
    subject { state.check_user_input }

    before do
      state.context = Context.new
      state.start_menu
      state.utils_menu
    end

    context 'when user input "exit"' do
      before { allow(io_mock).to receive(:read).and_return('exit') }
      it { is_expected.to eq :exit }
    end

    context 'when user input "1"' do
      before { allow(io_mock).to receive(:read).and_return('1') }
      it { is_expected.to eq :play }
    end

    context 'when user input "2"' do
      before { allow(io_mock).to receive(:read).and_return('2') }
      it { is_expected.to eq :load }
    end

    context 'when user input "3"' do
      before { allow(io_mock).to receive(:read).and_return('3') }
      it { is_expected.to eq :wrong_state }
    end

    context 'when user input "dfpdf"' do
      before { allow(io_mock).to receive(:read).and_return('dfpdf') }
      it { is_expected.to eq :wrong_state }
    end
  end
end

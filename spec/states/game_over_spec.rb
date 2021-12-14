require_relative '../../lib/context'
require './lib/states/game_over'
require './lib/io_adapter'

describe AppStates::GameOver do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:read)
    allow(io_mock).to receive(:clear)
    allow(io_mock).to receive(:write)
  end

  let(:game_over) { AppStates::GameOver.new }
  let(:context) { Context.new.transition_to_state AppStates::Welcome }
  describe '#render' do
    it 'renders correct game over menu' do
      game_over.render
      expect(io_mock).to have_received(:write).with(
        'You lose'
      )
      expect(io_mock).to have_received(:write).with(
        'CHOOSE YOUR DESTINY'
      )
      expect(io_mock).to have_received(:write).with(
        '|Back to start menu [back]|Exit [exit]|'
      )
    end
  end

  describe '#run' do
    context 'when user inputs "10"' do
      before do
        @game_over_state = AppStates::GameOver.new
        @context = Context.new
        @context.transition_to_state @game_over_state

        @context.state = @game_over_state
        @context.state.run
        allow(io_mock).to receive(:read).and_return('10')
      end
      it 'repeats state' do
        expect(@context.state).to be_a AppStates::GameOver
      end
    end
  end
end

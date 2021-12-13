require_relative '../../lib/states/exit'
require_relative '../../lib/io_adapter'

describe AppStates::Exit do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
    allow(io_mock).to receive(:clear)
  end

  let(:state) { AppStates::Exit.new }

  describe '#render' do
    it 'renders Goodbye' do
      state.render
      expect(io_mock).to have_received(:write).with(
        'Bye, have a beautiful time!!'
      )
    end
  end
end

require './lib/io_adapter'

RSpec.describe IOAdapter do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:read)
    allow(io_mock).to receive(:clear)
    allow(io_mock).to receive(:write)
  end
  context '#read' do
    subject { io_mock.read }
    context 'reads 2' do
      before { allow(io_mock).to receive(:read).and_return('2') }
      it { is_expected.to eq('2') }
    end
  end
  context '#write' do
    it 'writes 2' do
      io_mock.write 'Hello'
      expect(io_mock).to have_received(:write).with(
        'Hello'
      )
    end
  end
end

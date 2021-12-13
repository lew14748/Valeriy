require 'simplecov'
SimpleCov.start
require_relative '../lib/saver'
require_relative '../lib/loader'
require_relative '../lib/valera'

RSpec.describe Saver do
  let(:saver) { Saver.new }
  let(:loader) { Loader.new }
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  describe '#valid?' do
    context 'Check is number(5) allowed or not' do
      it { expect(saver.valid?(5)).to eq true }
    end
    context 'Check is number(f) allowed or not' do
      it { expect(saver.valid?('f')).to eq false }
    end
  end

  describe '#take_number_of_save' do
    context 'Take save number(1) or get zero' do
      it { expect(saver.take_number_of_save(1)).to eq 1 }
    end
    context 'Take save number(14) or get zero' do
      it { expect(saver.take_number_of_save(14)).to eq 0 }
    end
    context 'Take save number(f) or get zero' do
      it { expect(saver.take_number_of_save('f')).to eq 0 }
    end
  end

  describe '#check_save_folder' do
    context 'Creating folder if it does not exists' do
      before { saver.check_save_folder }
      subject { File.directory?('saves') }
      it { is_expected.to eq true }
    end
  end

  describe '#show_saves' do
    context 'Show all saves' do
      it { expect(saver.show_saves).to eq 1..9 }
    end
  end

  describe '#find_saves' do
    context 'Trying to find save files' do
      before { saver.find_saves }
      subject do
        File.file?('saves/save1.yml') && File.file?('saves/save2.yml') &&
          File.file?('saves/save3.yml') && File.file?('saves/save4.yml') &&
          File.file?('saves/save5.yml') && File.file?('saves/save6.yml') &&
          File.file?('saves/save7.yml') && File.file?('saves/save8.yml') &&
          File.file?('saves/save9.yml')
      end
      it { is_expected.to eq true }
    end
    context 'Creating saves if save folder is empty' do
      it {
        FileUtils.rm_r('saves')
        Dir.mkdir('saves')
        saver.find_saves
        expect(File.file?('saves/save9.yml')).to eq true
      }
    end
  end

  describe '#save_to_file' do
    context 'Save valera to file' do
      valera_stats = Valera.new
      it {
        saver.save_to_file(valera_stats, 9)
        valera_from_save = loader.load_save(9)
        expect(loader.load_save(9)).to eq valera_from_save
      }
    end
  end
end

require 'simplecov'
SimpleCov.start
require_relative '../lib/loader'

RSpec.describe Loader do
  let(:loader) { Loader.new }
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  describe '#valid?' do
    context 'Check is number(5) allowed or not' do
      it { expect(loader.valid?(5)).to eq true }
    end
    context 'Check is number(f) allowed or not' do
      it { expect(loader.valid?('f')).to eq false }
    end
  end

  describe '#take_number_of_save' do
    context 'Take save number(1) or get zero' do
      it { expect(loader.take_number_of_save(1)).to eq 1 }
    end
    context 'Take save number(14) or get zero' do
      it { expect(loader.take_number_of_save(14)).to eq 0 }
    end
    context 'Take save number(f) or get zero' do
      it { expect(loader.take_number_of_save('f')).to eq 0 }
    end
  end

  describe '#find_save_folder' do
    context 'Creating folder if it does not exists' do
      before { loader.find_save_folder }
      subject { File.directory?('saves') }
      it { is_expected.to eq true }
    end
  end

  describe '#show_saves' do
    context 'Show all saves' do
      it { expect(loader.show_saves).to eq 1..9 }
    end
  end

  describe '#find_saves' do
    context 'Trying to find save files' do
      before { loader.find_saves }
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
        loader.find_saves
        expect(File.file?('saves/save9.yml')).to eq true
      }
    end
  end

  describe '#load_save' do
    context 'Take nil from empty save file' do
      File.open('saves/save8.yml', 'w') { |file| file.write('') }
      it { expect(loader.load_save(8)).to eq nil }
    end
    context 'Give stats to var from save file' do
      stats = "-\n  health: 100\n  mana: 0\n  fun: 0\n  money: 0\n  fatigue: 0"
      valera_stats = [{ 'fatigue' => 0, 'fun' => 0, 'health' => 100, 'mana' => 0, 'money' => 0 }]
      it {
        File.open('saves/save9.yml', 'w') { |file| file.write(stats) }
        expect(loader.load_save(9)).to eq valera_stats
      }
    end
  end
end

require 'simplecov'
SimpleCov.start

require_relative '../lib/border_checker'

RSpec.describe BorderChecker do
  let(:border_checker) { BorderChecker.new 0, 100 }
  describe '#check' do
    it 'correctly passes value 10 to [0:100] scale' do
      expect(border_checker.check(10)).to eq [10, 0]
    end
    it 'correctly passes value 100 to [0:100] scale' do
      expect(border_checker.check(100)).to eq [100, 0]
    end
    it 'correctly passes value 150 to [0:100] scale' do
      expect(border_checker.check(150)).to eq [100, 50]
    end
    it 'correctly passes value -2 to [0:100] scale' do
      expect(border_checker.check(-2)).to eq [0, -2]
    end
  end
end

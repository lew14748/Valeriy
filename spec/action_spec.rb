require_relative '../lib/action'
require_relative '../lib/valera'
require_relative '../lib/action_loader'

RSpec.describe Action do
  let(:valera) do
    Valera.new
  end

  let(:all_action) do
    ActionLoader.new('actions.yml').load
  end

  let(:actions) do
    Action.new(all_action[1], valera)
  end

  let(:actions1) do
    Action.new(all_action[0], valera)
  end

  describe '#change_value' do
    context 'change the old value to the new one' do
      context 'change from 100 to 110' do
        subject { actions.change_value(100, '+', 10) }
        it { is_expected.to eq 110 }
      end

      context 'change from 110 to 100' do
        subject { actions.change_value(110, '-', 10) }
        it { is_expected.to eq 100 }
      end
    end
  end

  describe '#conds_correct' do
    context 'checks if the conditions for an action pass' do
      context 'incorrect conds' do
        subject { actions1.conds_correct? }
        it { is_expected.to eq false }
      end

      context 'correct conds' do
        subject { actions.conds_correct? }
        it { is_expected.to eq true }
      end
    end
  end

  describe '#do_effect' do
    context 'applies effects' do
      before { actions.do_effect }
      it 'money increased' do expect(valera.money).to eq 100 end
      it 'fatigue increased' do expect(valera.fatigue).to eq 20 end
      it 'fun decreased' do expect(valera.fun).to eq(-1) end
      it 'health decreased' do expect(valera.health).to eq 90 end
      it 'mana has not changed' do expect(valera.mana).to eq 0 end
    end
  end

  describe '#do_action' do
    context 'take action when conditions are met' do
      context 'correct conds' do
        before { actions.do_action }
        it 'money increased' do expect(valera.money).to eq 100 end
        it 'fatigue increased' do expect(valera.fatigue).to eq 20 end
        it 'fun decreased' do expect(valera.fun).to eq(-1) end
        it 'health decreased' do expect(valera.health).to eq 90 end
        it 'mana has not changed' do expect(valera.mana).to eq 0 end
      end

      context 'incorrect conds' do
        before { actions1.do_action }
        it 'money has not changed' do expect(valera.money).to eq 0 end
        it 'fatigue has not changed' do expect(valera.fatigue).to eq 0 end
        it 'fun has not changed' do expect(valera.fun).to eq 0 end
        it 'health has not changed' do expect(valera.health).to eq 100 end
        it 'mana has not changed' do expect(valera.mana).to eq 0 end
      end
    end
  end
end

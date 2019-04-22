describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:catalyze]) }

  describe 'catalyze' do
    describe 'target' do
      it { should validate deploy: { provider: :catalyze, target: 'str' } }
      it { should_not validate deploy: { provider: :catalyze, target: 1 } }
      it { should_not validate deploy: { provider: :catalyze, target: true } }
      it { should_not validate deploy: { provider: :catalyze, target: ['str'] } }
      it { should_not validate deploy: { provider: :catalyze, target: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :catalyze, target: [{:foo=>'foo'}] } }
    end

    describe 'path' do
      it { should validate deploy: { provider: :catalyze, path: 'str' } }
      it { should_not validate deploy: { provider: :catalyze, path: 1 } }
      it { should_not validate deploy: { provider: :catalyze, path: true } }
      it { should_not validate deploy: { provider: :catalyze, path: ['str'] } }
      it { should_not validate deploy: { provider: :catalyze, path: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :catalyze, path: [{:foo=>'foo'}] } }
    end
  end
end

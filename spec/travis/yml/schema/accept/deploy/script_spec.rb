describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:script]) }

  describe 'script' do
    describe 'script' do
      it { should validate deploy: { provider: :script, script: 'str' } }
      it { should_not validate deploy: { provider: :script, script: 1 } }
      it { should_not validate deploy: { provider: :script, script: true } }
      it { should_not validate deploy: { provider: :script, script: ['str'] } }
      it { should_not validate deploy: { provider: :script, script: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :script, script: [{:foo=>'foo'}] } }
    end
  end
end

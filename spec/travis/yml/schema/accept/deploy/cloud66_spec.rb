describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:cloud66]) }

  describe 'cloud66' do
    describe 'redeployment_hook' do
      it { should validate deploy: { provider: :cloud66, redeployment_hook: 'str' } }
      it { should_not validate deploy: { provider: :cloud66, redeployment_hook: 1 } }
      it { should_not validate deploy: { provider: :cloud66, redeployment_hook: true } }
      it { should_not validate deploy: { provider: :cloud66, redeployment_hook: ['str'] } }
      it { should_not validate deploy: { provider: :cloud66, redeployment_hook: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloud66, redeployment_hook: [{:foo=>'foo'}] } }
    end
  end
end

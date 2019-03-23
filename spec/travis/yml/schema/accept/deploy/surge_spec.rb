describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:surge]) }

  describe 'surge' do
    describe 'project' do
      it { should validate deploy: { provider: :surge, project: 'str' } }
      it { should_not validate deploy: { provider: :surge, project: 1 } }
      it { should_not validate deploy: { provider: :surge, project: true } }
      it { should_not validate deploy: { provider: :surge, project: ['str'] } }
      it { should_not validate deploy: { provider: :surge, project: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :surge, project: [{:foo=>'foo'}] } }
    end

    describe 'domain' do
      it { should validate deploy: { provider: :surge, domain: 'str' } }
      it { should_not validate deploy: { provider: :surge, domain: 1 } }
      it { should_not validate deploy: { provider: :surge, domain: true } }
      it { should_not validate deploy: { provider: :surge, domain: ['str'] } }
      it { should_not validate deploy: { provider: :surge, domain: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :surge, domain: [{:foo=>'foo'}] } }
    end
  end
end

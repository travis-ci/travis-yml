describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:npm]) }

  describe 'npm' do
    describe 'email' do
      it { should validate deploy: { provider: :npm, email: 'str' } }
      it { should_not validate deploy: { provider: :npm, email: 1 } }
      it { should_not validate deploy: { provider: :npm, email: true } }
      it { should_not validate deploy: { provider: :npm, email: ['str'] } }
      it { should_not validate deploy: { provider: :npm, email: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :npm, email: [{:foo=>'foo'}] } }
    end

    describe 'api_key' do
      it { should validate deploy: { provider: :npm, api_key: 'str' } }
      it { should_not validate deploy: { provider: :npm, api_key: 1 } }
      it { should_not validate deploy: { provider: :npm, api_key: true } }
      it { should_not validate deploy: { provider: :npm, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :npm, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :npm, api_key: [{:foo=>'foo'}] } }
    end
  end
end

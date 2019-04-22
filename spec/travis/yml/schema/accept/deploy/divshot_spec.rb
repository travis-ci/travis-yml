describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:divshot]) }

  describe 'divshot' do
    describe 'api_key' do
      it { should validate deploy: { provider: :divshot, api_key: 'str' } }
      it { should_not validate deploy: { provider: :divshot, api_key: 1 } }
      it { should_not validate deploy: { provider: :divshot, api_key: true } }
      it { should_not validate deploy: { provider: :divshot, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :divshot, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :divshot, api_key: [{:foo=>'foo'}] } }
    end

    describe 'environment' do
      it { should validate deploy: { provider: :divshot, environment: 'str' } }
      it { should_not validate deploy: { provider: :divshot, environment: 1 } }
      it { should_not validate deploy: { provider: :divshot, environment: true } }
      it { should_not validate deploy: { provider: :divshot, environment: ['str'] } }
      it { should_not validate deploy: { provider: :divshot, environment: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :divshot, environment: [{:foo=>'foo'}] } }
    end
  end
end

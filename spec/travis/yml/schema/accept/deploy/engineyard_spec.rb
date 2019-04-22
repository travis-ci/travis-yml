describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:engineyard]) }

  describe 'engineyard' do
    describe 'username' do
      it { should validate deploy: { provider: :engineyard, username: 'str' } }
      it { should_not validate deploy: { provider: :engineyard, username: 1 } }
      it { should_not validate deploy: { provider: :engineyard, username: true } }
      it { should_not validate deploy: { provider: :engineyard, username: ['str'] } }
      it { should_not validate deploy: { provider: :engineyard, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :engineyard, username: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :engineyard, password: 'str' } }
      it { should_not validate deploy: { provider: :engineyard, password: 1 } }
      it { should_not validate deploy: { provider: :engineyard, password: true } }
      it { should_not validate deploy: { provider: :engineyard, password: ['str'] } }
      it { should_not validate deploy: { provider: :engineyard, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :engineyard, password: [{:foo=>'foo'}] } }
    end

    describe 'api_key' do
      it { should validate deploy: { provider: :engineyard, api_key: 'str' } }
      it { should_not validate deploy: { provider: :engineyard, api_key: 1 } }
      it { should_not validate deploy: { provider: :engineyard, api_key: true } }
      it { should_not validate deploy: { provider: :engineyard, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :engineyard, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :engineyard, api_key: [{:foo=>'foo'}] } }
    end

    describe 'app' do
      it { should validate deploy: { provider: :engineyard, app: 'str' } }
      it { should_not validate deploy: { provider: :engineyard, app: 1 } }
      it { should_not validate deploy: { provider: :engineyard, app: true } }
      it { should_not validate deploy: { provider: :engineyard, app: ['str'] } }
      it { should_not validate deploy: { provider: :engineyard, app: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :engineyard, app: [{:foo=>'foo'}] } }
    end

    describe 'environment' do
      it { should validate deploy: { provider: :engineyard, environment: 'str' } }
      it { should_not validate deploy: { provider: :engineyard, environment: 1 } }
      it { should_not validate deploy: { provider: :engineyard, environment: true } }
      it { should_not validate deploy: { provider: :engineyard, environment: ['str'] } }
      it { should_not validate deploy: { provider: :engineyard, environment: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :engineyard, environment: [{:foo=>'foo'}] } }
    end

    describe 'migrate' do
      it { should validate deploy: { provider: :engineyard, migrate: 'str' } }
      it { should_not validate deploy: { provider: :engineyard, migrate: 1 } }
      it { should_not validate deploy: { provider: :engineyard, migrate: true } }
      it { should_not validate deploy: { provider: :engineyard, migrate: ['str'] } }
      it { should_not validate deploy: { provider: :engineyard, migrate: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :engineyard, migrate: [{:foo=>'foo'}] } }
    end
  end
end

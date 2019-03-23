describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:scalingo]) }

  describe 'scalingo' do
    describe 'username' do
      it { should validate deploy: { provider: :scalingo, username: 'str' } }
      it { should_not validate deploy: { provider: :scalingo, username: 1 } }
      it { should_not validate deploy: { provider: :scalingo, username: true } }
      it { should_not validate deploy: { provider: :scalingo, username: ['str'] } }
      it { should_not validate deploy: { provider: :scalingo, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :scalingo, username: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :scalingo, password: 'str' } }
      it { should_not validate deploy: { provider: :scalingo, password: 1 } }
      it { should_not validate deploy: { provider: :scalingo, password: true } }
      it { should_not validate deploy: { provider: :scalingo, password: ['str'] } }
      it { should_not validate deploy: { provider: :scalingo, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :scalingo, password: [{:foo=>'foo'}] } }
    end

    describe 'api_key' do
      it { should validate deploy: { provider: :scalingo, api_key: 'str' } }
      it { should_not validate deploy: { provider: :scalingo, api_key: 1 } }
      it { should_not validate deploy: { provider: :scalingo, api_key: true } }
      it { should_not validate deploy: { provider: :scalingo, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :scalingo, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :scalingo, api_key: [{:foo=>'foo'}] } }
    end

    describe 'remote' do
      it { should validate deploy: { provider: :scalingo, remote: 'str' } }
      it { should_not validate deploy: { provider: :scalingo, remote: 1 } }
      it { should_not validate deploy: { provider: :scalingo, remote: true } }
      it { should_not validate deploy: { provider: :scalingo, remote: ['str'] } }
      it { should_not validate deploy: { provider: :scalingo, remote: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :scalingo, remote: [{:foo=>'foo'}] } }
    end

    describe 'branch' do
      it { should validate deploy: { provider: :scalingo, branch: 'str' } }
      it { should_not validate deploy: { provider: :scalingo, branch: 1 } }
      it { should_not validate deploy: { provider: :scalingo, branch: true } }
      it { should_not validate deploy: { provider: :scalingo, branch: ['str'] } }
      it { should_not validate deploy: { provider: :scalingo, branch: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :scalingo, branch: [{:foo=>'foo'}] } }
    end

    describe 'app' do
      it { should validate deploy: { provider: :scalingo, app: 'str' } }
      it { should_not validate deploy: { provider: :scalingo, app: 1 } }
      it { should_not validate deploy: { provider: :scalingo, app: true } }
      it { should_not validate deploy: { provider: :scalingo, app: ['str'] } }
      it { should_not validate deploy: { provider: :scalingo, app: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :scalingo, app: [{:foo=>'foo'}] } }
    end
  end
end

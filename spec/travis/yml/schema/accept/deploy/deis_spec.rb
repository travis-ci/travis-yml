describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:deis]) }

  describe 'deis' do
    describe 'controller' do
      it { should validate deploy: { provider: :deis, controller: 'str' } }
      it { should_not validate deploy: { provider: :deis, controller: 1 } }
      it { should_not validate deploy: { provider: :deis, controller: true } }
      it { should_not validate deploy: { provider: :deis, controller: ['str'] } }
      it { should_not validate deploy: { provider: :deis, controller: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :deis, controller: [{:foo=>'foo'}] } }
    end

    describe 'username' do
      it { should validate deploy: { provider: :deis, username: 'str' } }
      it { should_not validate deploy: { provider: :deis, username: 1 } }
      it { should_not validate deploy: { provider: :deis, username: true } }
      it { should_not validate deploy: { provider: :deis, username: ['str'] } }
      it { should_not validate deploy: { provider: :deis, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :deis, username: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :deis, password: 'str' } }
      it { should_not validate deploy: { provider: :deis, password: 1 } }
      it { should_not validate deploy: { provider: :deis, password: true } }
      it { should_not validate deploy: { provider: :deis, password: ['str'] } }
      it { should_not validate deploy: { provider: :deis, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :deis, password: [{:foo=>'foo'}] } }
    end

    describe 'app' do
      it { should validate deploy: { provider: :deis, app: 'str' } }
      it { should_not validate deploy: { provider: :deis, app: 1 } }
      it { should_not validate deploy: { provider: :deis, app: true } }
      it { should_not validate deploy: { provider: :deis, app: ['str'] } }
      it { should_not validate deploy: { provider: :deis, app: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :deis, app: [{:foo=>'foo'}] } }
    end

    describe 'cli_version' do
      it { should validate deploy: { provider: :deis, cli_version: 'str' } }
      it { should_not validate deploy: { provider: :deis, cli_version: 1 } }
      it { should_not validate deploy: { provider: :deis, cli_version: true } }
      it { should_not validate deploy: { provider: :deis, cli_version: ['str'] } }
      it { should_not validate deploy: { provider: :deis, cli_version: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :deis, cli_version: [{:foo=>'foo'}] } }
    end
  end
end

describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:packagecloud]) }

  describe 'packagecloud' do
    describe 'username' do
      it { should validate deploy: { provider: :packagecloud, username: 'str' } }
      it { should_not validate deploy: { provider: :packagecloud, username: 1 } }
      it { should_not validate deploy: { provider: :packagecloud, username: true } }
      it { should_not validate deploy: { provider: :packagecloud, username: ['str'] } }
      it { should_not validate deploy: { provider: :packagecloud, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :packagecloud, username: [{:foo=>'foo'}] } }
    end

    describe 'token' do
      it { should validate deploy: { provider: :packagecloud, token: 'str' } }
      it { should_not validate deploy: { provider: :packagecloud, token: 1 } }
      it { should_not validate deploy: { provider: :packagecloud, token: true } }
      it { should_not validate deploy: { provider: :packagecloud, token: ['str'] } }
      it { should_not validate deploy: { provider: :packagecloud, token: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :packagecloud, token: [{:foo=>'foo'}] } }
    end

    describe 'repository' do
      it { should validate deploy: { provider: :packagecloud, repository: 'str' } }
      it { should_not validate deploy: { provider: :packagecloud, repository: 1 } }
      it { should_not validate deploy: { provider: :packagecloud, repository: true } }
      it { should_not validate deploy: { provider: :packagecloud, repository: ['str'] } }
      it { should_not validate deploy: { provider: :packagecloud, repository: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :packagecloud, repository: [{:foo=>'foo'}] } }
    end

    describe 'local_dir' do
      it { should validate deploy: { provider: :packagecloud, local_dir: 'str' } }
      it { should_not validate deploy: { provider: :packagecloud, local_dir: 1 } }
      it { should_not validate deploy: { provider: :packagecloud, local_dir: true } }
      it { should_not validate deploy: { provider: :packagecloud, local_dir: ['str'] } }
      it { should_not validate deploy: { provider: :packagecloud, local_dir: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :packagecloud, local_dir: [{:foo=>'foo'}] } }
    end

    describe 'dist' do
      it { should validate deploy: { provider: :packagecloud, dist: 'str' } }
      it { should_not validate deploy: { provider: :packagecloud, dist: 1 } }
      it { should_not validate deploy: { provider: :packagecloud, dist: true } }
      it { should_not validate deploy: { provider: :packagecloud, dist: ['str'] } }
      it { should_not validate deploy: { provider: :packagecloud, dist: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :packagecloud, dist: [{:foo=>'foo'}] } }
    end

    describe 'package_glob' do
      it { should validate deploy: { provider: :packagecloud, package_glob: 'str' } }
      it { should_not validate deploy: { provider: :packagecloud, package_glob: 1 } }
      it { should_not validate deploy: { provider: :packagecloud, package_glob: true } }
      it { should_not validate deploy: { provider: :packagecloud, package_glob: ['str'] } }
      it { should_not validate deploy: { provider: :packagecloud, package_glob: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :packagecloud, package_glob: [{:foo=>'foo'}] } }
    end

    describe 'force' do
      it { should validate deploy: { provider: :packagecloud, force: true } }
      it { should_not validate deploy: { provider: :packagecloud, force: 1 } }
      it { should_not validate deploy: { provider: :packagecloud, force: 'str' } }
      it { should_not validate deploy: { provider: :packagecloud, force: ['str'] } }
      it { should_not validate deploy: { provider: :packagecloud, force: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :packagecloud, force: [{:foo=>'foo'}] } }
    end
  end
end

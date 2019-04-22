describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:releases]) }

  describe 'releases' do
    describe 'user' do
      it { should validate deploy: { provider: :releases, user: 'str' } }
      it { should_not validate deploy: { provider: :releases, user: 1 } }
      it { should_not validate deploy: { provider: :releases, user: true } }
      it { should_not validate deploy: { provider: :releases, user: ['str'] } }
      it { should_not validate deploy: { provider: :releases, user: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, user: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :releases, password: 'str' } }
      it { should_not validate deploy: { provider: :releases, password: 1 } }
      it { should_not validate deploy: { provider: :releases, password: true } }
      it { should_not validate deploy: { provider: :releases, password: ['str'] } }
      it { should_not validate deploy: { provider: :releases, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, password: [{:foo=>'foo'}] } }
    end

    describe 'api_key' do
      it { should validate deploy: { provider: :releases, api_key: 'str' } }
      it { should_not validate deploy: { provider: :releases, api_key: 1 } }
      it { should_not validate deploy: { provider: :releases, api_key: true } }
      it { should_not validate deploy: { provider: :releases, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :releases, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, api_key: [{:foo=>'foo'}] } }
    end

    describe 'repo' do
      it { should validate deploy: { provider: :releases, repo: 'str' } }
      it { should_not validate deploy: { provider: :releases, repo: 1 } }
      it { should_not validate deploy: { provider: :releases, repo: true } }
      it { should_not validate deploy: { provider: :releases, repo: ['str'] } }
      it { should_not validate deploy: { provider: :releases, repo: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, repo: [{:foo=>'foo'}] } }
    end

    describe 'file' do
      it { should validate deploy: { provider: :releases, file: 'str' } }
      it { should validate deploy: { provider: :releases, file: ['str'] } }
      it { should_not validate deploy: { provider: :releases, file: 1 } }
      it { should_not validate deploy: { provider: :releases, file: true } }
      it { should_not validate deploy: { provider: :releases, file: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, file: [{:foo=>'foo'}] } }
    end

    describe 'file_glob' do
      it { should validate deploy: { provider: :releases, file_glob: 'str' } }
      it { should_not validate deploy: { provider: :releases, file_glob: 1 } }
      it { should_not validate deploy: { provider: :releases, file_glob: true } }
      it { should_not validate deploy: { provider: :releases, file_glob: ['str'] } }
      it { should_not validate deploy: { provider: :releases, file_glob: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, file_glob: [{:foo=>'foo'}] } }
    end

    describe 'overwrite' do
      it { should validate deploy: { provider: :releases, overwrite: 'str' } }
      it { should_not validate deploy: { provider: :releases, overwrite: 1 } }
      it { should_not validate deploy: { provider: :releases, overwrite: true } }
      it { should_not validate deploy: { provider: :releases, overwrite: ['str'] } }
      it { should_not validate deploy: { provider: :releases, overwrite: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, overwrite: [{:foo=>'foo'}] } }
    end

    describe 'release_number' do
      it { should validate deploy: { provider: :releases, release_number: 'str' } }
      it { should_not validate deploy: { provider: :releases, release_number: 1 } }
      it { should_not validate deploy: { provider: :releases, release_number: true } }
      it { should_not validate deploy: { provider: :releases, release_number: ['str'] } }
      it { should_not validate deploy: { provider: :releases, release_number: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, release_number: [{:foo=>'foo'}] } }
    end

    describe 'prerelease' do
      it { should validate deploy: { provider: :releases, prerelease: true } }
      it { should_not validate deploy: { provider: :releases, prerelease: 1 } }
      it { should_not validate deploy: { provider: :releases, prerelease: 'str' } }
      it { should_not validate deploy: { provider: :releases, prerelease: ['str'] } }
      it { should_not validate deploy: { provider: :releases, prerelease: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :releases, prerelease: [{:foo=>'foo'}] } }
    end
  end
end

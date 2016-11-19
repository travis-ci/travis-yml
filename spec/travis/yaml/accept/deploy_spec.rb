describe Travis::Yaml, 'deploy' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  describe 'given true' do
    let(:input) { { deploy: true } }
    it { expect(deploy).to be nil }
    it { expect(msgs).to include [:error, :'deploy', :invalid_type, expected: :map, actual: :bool, value: true] }
  end

  describe 'given an empty hash' do
    let(:input) { { deploy: {} } }
    it { expect(deploy).to be_nil }
    it { expect(msgs).to include([:warn, :root, :empty, key: :deploy]) }
  end

  describe 'given a string' do
    let(:input) { { deploy: 'heroku' } }
    it { expect(deploy).to eq [provider: 'heroku'] }
    it { expect(msgs).to be_empty }
  end

  describe 'provider given as a hash' do
    let(:input) { { deploy: { provider: { provider: 'heroku' } } } }
    it { expect(deploy).to be_nil }
    it { expect(msgs).to include [:error, :'deploy.provider', :invalid_type, expected: :str, actual: :map, value: { provider: 'heroku' }] }
  end

  describe 'given a hash' do
    describe 'without a provider' do
      let(:input) { { deploy: { foo: 'foo' } } }
      it { expect(deploy).to be_nil }
      it { expect(msgs).to include [:error, :deploy, :required, key: :provider] }
    end

    describe 'with a provider' do
      let(:input) { { deploy: { provider: 'heroku' } } }
      it { expect(deploy).to eq [provider: 'heroku'] }
    end

    # TODO check if we really need/want this case, remove Scalar from Deploy.type if we don't
    describe 'with extra data (string)' do
      let(:input) { { deploy: { provider: 'heroku', foo: 'bar' } } }
      it { expect(deploy).to eq [provider: 'heroku', foo: 'bar'] }
    end

    describe 'with extra data (hash)' do
      let(:input) { { deploy: { provider: 'heroku', foo: { bar: 'baz' } } } }
      it { expect(deploy).to eq [provider: 'heroku', foo: { bar: 'baz' }] }
    end

    describe 'with a secure string' do
      let(:input) { { deploy: { provider: 'heroku', api_key: { secure: 'secure' } } } }
      it { expect(deploy).to eq [provider: 'heroku', api_key: { secure: 'secure' }] }
    end
  end

  describe 'given an array' do
    describe 'with a provider' do
      let(:input) { { deploy: [{ provider: 'heroku' }, { provider: 's3' }] } }
      it { expect(deploy).to eq [{ provider: 'heroku' }, { provider: 's3' } ] }
    end

    describe 'with extra data (string)' do
      let(:input) { { deploy: [{ provider: 'heroku', foo: 'bar' }] } }
      it { expect(deploy).to eq [{ provider: 'heroku', foo: 'bar' }] }
    end

    describe 'with extra data (hash)' do
      let(:input) { { deploy: [{ provider: 'heroku', foo: { bar: 'baz' } }] } }
      it { expect(deploy).to eq [{ provider: 'heroku', foo: { bar: 'baz' } }] }
    end

    describe 'with a secure string' do
      let(:input) { { deploy: [{ provider: 'heroku', api_key: { secure: 'secure' } }] } }
      it { expect(deploy).to eq [provider: 'heroku', api_key: { secure: 'secure' }] }
    end
  end

  describe 'conditions' do
    describe 'given a string' do
      let(:input) { { deploy: { provider: 'heroku', on: 'master' } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { branch: ['master'] }] }
    end

    describe 'given a hash' do
      let(:input) { { deploy: { provider: 'heroku', on: { ruby: '2.3.0', repo: 'foo/bar', tags: true } } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { rvm: '2.3.0', repo: 'foo/bar', tags: true }] }
    end

    describe 'repo' do
      let(:input) { { deploy: { provider: 'heroku', on: { repo: 'foo/bar' } } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { repo: 'foo/bar' }] }
    end

    describe 'all_branches' do
      let(:input) { { deploy: { provider: 'heroku', on: { all_branches: true } } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { all_branches: true }] }
    end

    describe 'language specific setting' do
      let(:input) { { deploy: { provider: 'heroku', on: { ruby: '2.3.1' } } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { rvm: '2.3.1' }] }
    end

    describe 'language specific setting (with an alias)' do
      let(:input) { { deploy: { provider: 'heroku', on: { ruby: '2.3.1' } } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { rvm: '2.3.1' }] }
    end

    describe 'branch specific option hashes (holy shit. example for a valid hash from travis-build)' do
      let(:input) { { deploy: { provider: 'heroku', on: { branch: { production: { bucket: 'production_branch' } } } } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { branch: { production: { bucket: 'production_branch' } } }] }
      it { expect(msgs).to be_empty }
    end

    describe 'option specific branch hashes (deprecated, according to travis-build)' do
      let(:input) { { deploy: { provider: 'heroku', run: { production: 'production' } } } }
      it { expect(deploy).to eq [provider: 'heroku', run: { production: 'production' }] }
      it { expect(msgs).to include [:warn, :'deploy.run', :deprecated, key: :run, info: :branch_specific_option_hash] }
    end

    describe 'migrating :tags, with :tags already given' do
      let(:input) { { deploy: { provider: 'releases', tags: true, on: { tags: true } } } }
      # not possible because deploy is not strict?
      xit { expect(msgs).to include [:warn, :deploy, :migrate, key: :tags, to: :on, value: true] }
    end
  end

  describe 'allow_failure' do
    let(:input) { { deploy: { provider: 'heroku', allow_failure: true } } }
    it { expect(deploy).to eq [provider: 'heroku', allow_failure: true] }
  end

  describe 'branches in settings that are not in the condition' do
    let(:input) { { deploy: { provider: 'heroku', app: { master: 'production', dev: 'staging' }, on: 'master' } } }
    it { expect(deploy).to eq [provider: 'heroku', app: { master: 'production', dev: 'staging' }, on: { branch: ['master'] }] }
    # would need very specific validation
    xit { expect(msgs).to include [:error, :dev, :invalid_branch, 'branch "dev" not permitted by deploy condition, dropping'] }
  end

  describe 'edge' do
    describe 'given a bool' do
      let(:input) { { deploy: { provider: 'heroku', edge: true } } }
      it { expect(deploy).to eq [provider: 'heroku', edge: true] }
    end

    describe 'given a hash' do
      let(:input) { { deploy: { provider: 'heroku', edge: { source: 'source', branch: 'branch' } } } }
      it { expect(deploy).to eq [provider: 'heroku', edge: { source: 'source', branch: 'branch' }] }
    end
  end

  describe 'misplaced keys' do
    let(:input) { { deploy: { edge: true }, provider: 'heroku', api_key: 'api_key' } }
    it { expect(deploy).to eq [provider: 'heroku', edge: true, api_key: 'api_key'] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :provider, to: :deploy, value: 'heroku'] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :api_key, to: :deploy, value: 'api_key'] }
  end

  describe 'misplaced keys (2)' do
    let(:input) { { deploy: { edge: true }, api_key: 'api_key', provider: 'heroku' } }
    it { expect(deploy).to eq [provider: 'heroku', edge: true, api_key: 'api_key'] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :provider, to: :deploy, value: 'heroku'] }
    it { expect(msgs).to include [:warn, :root, :migrate, key: :api_key, to: :deploy, value: 'api_key'] }
  end

  describe 'misplaced key that would result in an invalid node if migrated' do
    let(:input) { { file: 'file' } }
    it { expect(deploy).to be_nil }
    it { expect(msgs).to include [:error, :root, :misplaced_key, key: :file, value: 'file'] }
  end
end

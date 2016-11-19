describe Travis::Yaml, 'deploy' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply({ language: 'ruby', sudo: false }.merge(input)) }

  describe 'given an empty hash' do
    let(:input) { { deploy: {} } }
    it { expect(deploy).to be_nil }
    it { expect(msgs).to include([:error, :deploy, :empty, 'dropping empty section :deploy']) }
  end

  describe 'given a string' do
    let(:input) { { deploy: 'heroku' } }
    it { expect(deploy).to eq [provider: 'heroku'] }
    it { expect(msgs).to be_empty }
  end

  describe 'given a hash' do
    describe 'without a provider' do
      let(:input) { { deploy: { foo: 'foo' } } }
      it { expect(deploy).to be_nil }
      it { expect(msgs).to include [:error, :deploy, :required, 'missing required key :provider'] }
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
      it { expect(deploy).to eq [provider: 'heroku', on: { ruby: '2.3.0', repo: 'foo/bar', tags: true }] }
    end

    describe 'repo' do
      let(:input) { { deploy: { provider: 'heroku', on: { repo: 'foo/bar' } } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { repo: 'foo/bar' }] }
    end

    describe 'all_branches' do
      let(:input) { { deploy: { provider: 'heroku', on: { all_branches: true } } } }
      it { expect(deploy).to eq [provider: 'heroku', on: { all_branches: true }] }
    end
  end

  # shouldn't this be an explicit :app key instead?
  # https://docs.travis-ci.com/user/deployment/heroku/#Deploying-Custom-Application-Names
  describe 'with branch specific settings' do
    let(:input) { { deploy: { provider: 'heroku', app: { master: 'production', dev: 'staging' } } } }
    it { expect(deploy).to eq [provider: 'heroku', app: { master: 'production', dev: 'staging' }] }
  end

  # TODO would need very specific validation
  describe 'branches in settings that are not in the condition' do
    let(:input) { { deploy: { provider: 'heroku', app: { master: 'production', dev: 'staging' }, on: 'master' } } }
    xit { expect(deploy).to eq [provider: 'heroku', app: { master: 'production' }, on: { branch: ['master'] }] }
    xit { expect(msgs).to include [:error, :dev, :invalid_branch, 'branch "dev" not permitted by deploy condition, dropping'] }
  end
end

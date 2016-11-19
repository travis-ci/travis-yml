describe Travis::Yaml, 'deploy heroku' do
  let(:deploy)   { subject.serialize[:deploy].first }
  let(:strategy) { 'api' }
  let(:api_key)  { 'key' }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'heroku',
        strategy: strategy,
        buildpack: 'buildpack',
        app: 'app',
        api_key: api_key,
        run: ['run'],
      }
    }
  end

  describe 'api_key given as a string' do
    let(:api_key) { 'key' }
    it { expect(deploy[:api_key]).to eq 'key' }
  end

  describe 'api_key given as a secure string' do
    let(:api_key) { { secure: 'secure' } }
    it { expect(deploy[:api_key]).to eq secure: 'secure' }
  end

  describe 'strategy anvil' do
    let(:strategy) { 'anvil' }
    it { expect(deploy[:strategy]).to eq 'anvil' }

    describe 'given a version greater than 1.0.0' do
      let(:input) { { version: '~> 1.1', deploy: { provider: 'heroku', strategy: 'anvil' } } }
      it { expect(deploy[:strategy]).to eq 'api' }
      it { expect(msgs).to include [:warn, :'deploy.strategy', :deprecated, key: :strategy, info: 'will be removed in v1.1.0', value: 'anvil'] }
    end
  end
end

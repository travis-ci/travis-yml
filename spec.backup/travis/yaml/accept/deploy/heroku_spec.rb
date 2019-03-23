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
end

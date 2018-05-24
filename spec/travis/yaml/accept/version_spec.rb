describe Travis::Yaml, 'version' do
  let(:config) { subject.serialize }
  let(:opts)   { {} }

  subject { described_class.apply(input, opts) }

  describe 'given a string' do
    let(:input) { { version: '~> 1.0.1' } }
    it { expect(config[:version]).to eq '~> 1.0.1' }
  end

  describe 'given a requirement that is greater than a node value version' do
    let(:input) { { version: '~> 1.1.0', deploy: { provider: 'heroku', strategy: 'git-ssh' } } }
    it { expect(config[:deploy]).to eq [provider: 'heroku', strategy: 'api'] }
    it { expect(msgs).to include [:error, :'deploy.strategy', :invalid_version, key: :strategy, version: '1.0', required: '~> 1.1.0'] }
    it { expect(info).to include [:info, :'deploy.strategy', :default, key: :strategy, default: 'api'] }
  end
end

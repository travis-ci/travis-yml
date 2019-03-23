describe Travis::Yml, 'prefix' do
  subject { described_class.apply(value) }

  describe 'deploy.on given a str' do
    let(:value) { { deploy: { provider: 'script', on: 'master' } } }
    it { should serialize_to deploy: [{ provider: 'script', on: { branch: ['master'] } }] }
  end
end

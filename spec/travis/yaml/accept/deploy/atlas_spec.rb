describe Travis::Yaml, 'deploy atlas' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'atlas',
        token: token,
        app: 'app',
        exclude: ['exclude'],
        include: ['include'],
        address: 'address',
        vcs: true,
        metadata: ['metadata'],
        debug: true,
        version: 'version',
      }
    }
  end

  describe 'token given as a string' do
    let(:token) { 'token' }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'token given as a secure string' do
    let(:token) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

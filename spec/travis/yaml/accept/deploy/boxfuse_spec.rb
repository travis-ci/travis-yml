describe Travis::Yaml, 'deploy boxfuse' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:user)   { 'user' }
  let(:secret) { 'secret' }

  let(:input) do
    {
      deploy: {
        provider: 'boxfuse',
        user: user,
        secret: secret,
        configfile: 'configfile',
        payload: 'payload',
        app: 'app',
        version: 'version',
        env: 'env',
        image: 'image',
        extra_args: 'extra_args',
      }
    }
  end

  describe 'user, and secret given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'user given as a secure string' do
    let(:user) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'secret given as a secure string' do
    let(:secret) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

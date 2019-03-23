describe Travis::Yaml, 'deploy launchpad' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:oauth_token) { 'oauth_token' }
  let(:oauth_token_secret) { 'oauth_token_secret' }

  let(:input) do
    {
      deploy: {
        provider: 'launchpad',
        slug: 'slug',
        oauth_token: 'oauth_token',
        oauth_token_secret: 'oauth_token_secret',
      }
    }
  end

  describe 'oauth_token, and oauth_token_secret given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'oauth_token given as a secure string' do
    let(:oauth_token) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'oauth_token_secret given as a secure string' do
    let(:oauth_token_secret) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

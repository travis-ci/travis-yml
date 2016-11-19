describe Travis::Yaml, 'deploy cloudfiles' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:username) { 'username' }
  let(:api_key)  { 'api_key' }

  let(:input) do
    {
      deploy: {
        provider: 'cloudfiles',
        username: username,
        api_key: api_key,
        region: 'region',
        container: 'container',
        dot_match: true
      }
    }
  end

  describe 'username, and api_key given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'username given as a secure string' do
    let(:username) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'api_key given as a secure string' do
    let(:api_key) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

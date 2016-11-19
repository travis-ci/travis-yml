describe Travis::Yaml, 'deploy cloudfoundry' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:username) { 'username' }
  let(:password) { 'password' }

  let(:input) do
    {
      deploy: {
        provider: 'cloudfoundry',
        username: username,
        password: password,
        organization: 'organization',
        api: 'api',
        space: 'space',
        key: 'key',
        manifest: 'manifest',
        skip_ssl_validation: true
      }
    }
  end

  describe 'username, and password given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'username given as a secure string' do
    let(:username) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'password given as a secure string' do
    let(:password) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

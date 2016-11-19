describe Travis::Yaml, 'deploy scalingo' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:username) { 'username' }
  let(:password) { 'password' }
  let(:api_key)  { 'api_key' }

  let(:input) do
    {
      deploy: {
        provider: 'scalingo',
        api_key: api_key,
        username: username,
        password: password,
        remote: 'remote',
        branch: 'branch',
        app: 'app',
      }
    }
  end

  describe 'username, password, and api_key given as strings' do
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

  describe 'api_key given as a secure string' do
    let(:api_key) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

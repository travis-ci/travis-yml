describe Travis::Yaml, 'deploy appfog' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:user)     { 'user' }
  let(:password) { 'password' }
  let(:api_key)  { 'api_key' }
  let(:email)    { 'email' }

  let(:input) do
    {
      deploy: {
        provider: 'appfog',
        user: user,
        password: password,
        email: email,
        api_key: api_key,
        app: 'app',
        address: ['address'],
        metadata: 'metadata',
        after_deploy: ['after_deploy']
      }
    }
  end

  describe 'user, password, email, and api_key given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'user given as a a hash with strings' do
    let(:user) { { staging: 'user', production: 'user' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'user given as a secure string' do
    let(:user) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'user given as a hash with secure strings' do
    let(:user) { { production: { secure: 'user' } } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'password given as a hash with strings' do
    let(:password) { { staging: 'password', production: 'password' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'password given as a secure string' do
    let(:password) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'password given as an hash with secure strings' do
    let(:password) { { production: { secure: 'password' } } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'email given as an hash with strings' do
    let(:email) { { staging: 'user', production: 'user' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'email given as a secure string' do
    let(:email) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'email given as a hash with secure strings' do
    let(:email) { { production: { secure: 'email' } } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'api_key given as a hash with strings' do
    let(:api_key) { { production: 'api_key' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'api_key given as a secure string' do
    let(:api_key) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'api_key given as a hash with secure strings' do
    let(:api_key) { { production: { secure: 'api_key' } } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

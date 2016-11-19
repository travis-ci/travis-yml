describe Travis::Yaml, 'deploy pypi' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:user)     { 'user' }
  let(:password) { 'password' }
  let(:api_key)  { 'api_key' }

  let(:input) do
    {
      deploy: {
        provider: 'pypi',
        user: user,
        password: password,
        api_key: api_key,
        server: 'server',
        distributions: 'distributions',
        docs_dir: 'docs_dir',
      }
    }
  end

  describe 'user, password, and api_key given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'user given as a secure string' do
    let(:user) { { secure: 'secure' } }
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

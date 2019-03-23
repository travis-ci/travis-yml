describe Travis::Yaml, 'deploy releases' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:user)     { 'user' }
  let(:password) { 'password' }
  let(:api_key)  { 'api_key' }

  let(:input) do
    {
      deploy: {
        provider: 'releases',
        api_key: api_key,
        user: user,
        password: password,
        repo: 'repo',
        file: 'file',
        file_glob: 'file_glob',
        overwrite: 'overwrite',
        release_number: 'release_number',
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

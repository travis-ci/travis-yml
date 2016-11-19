describe Travis::Yaml, 'deploy packagecloud' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:username) { 'username' }
  let(:token)    { 'token' }

  let(:input) do
    {
      deploy: {
        provider: 'packagecloud',
        username: username,
        token: token,
        repository: 'repository',
        local_dir: 'local_dir',
        dist: 'dist',
        package_glob: 'package_glob',
      }
    }
  end

  describe 'username, and token given as strings' do
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'username given as a secure string' do
    let(:username) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'token given as a secure string' do
    let(:token) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

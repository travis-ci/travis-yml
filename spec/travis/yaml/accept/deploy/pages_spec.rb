describe Travis::Yaml, 'deploy pages' do
  let(:msgs)   { subject.msgs }
  let(:deploy) { subject.to_h[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'pages',
        github_token: github_token,
        repo: 'repo',
        target_branch: 'target_branch',
        local_dir: 'local_dir',
        fqdn: 'fqdn',
        project_name: 'project_name',
        email: 'email',
        name: 'name',
      }
    }
  end

  describe 'github_token given as a string' do
    let(:github_token) { 'github_token' }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'github_token given as a secure string' do
    let(:github_token) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

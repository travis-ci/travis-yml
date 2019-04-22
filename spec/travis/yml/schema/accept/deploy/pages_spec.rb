describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:pages]) }

  describe 'pages' do
    describe 'github_token' do
      it { should validate deploy: { provider: :pages, github_token: 'str' } }
      it { should_not validate deploy: { provider: :pages, github_token: 1 } }
      it { should_not validate deploy: { provider: :pages, github_token: true } }
      it { should_not validate deploy: { provider: :pages, github_token: ['str'] } }
      it { should_not validate deploy: { provider: :pages, github_token: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, github_token: [{:foo=>'foo'}] } }
    end

    describe 'repo' do
      it { should validate deploy: { provider: :pages, repo: 'str' } }
      it { should_not validate deploy: { provider: :pages, repo: 1 } }
      it { should_not validate deploy: { provider: :pages, repo: true } }
      it { should_not validate deploy: { provider: :pages, repo: ['str'] } }
      it { should_not validate deploy: { provider: :pages, repo: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, repo: [{:foo=>'foo'}] } }
    end

    describe 'target_branch' do
      it { should validate deploy: { provider: :pages, target_branch: 'str' } }
      it { should_not validate deploy: { provider: :pages, target_branch: 1 } }
      it { should_not validate deploy: { provider: :pages, target_branch: true } }
      it { should_not validate deploy: { provider: :pages, target_branch: ['str'] } }
      it { should_not validate deploy: { provider: :pages, target_branch: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, target_branch: [{:foo=>'foo'}] } }
    end

    describe 'local_dir' do
      it { should validate deploy: { provider: :pages, local_dir: 'str' } }
      it { should_not validate deploy: { provider: :pages, local_dir: 1 } }
      it { should_not validate deploy: { provider: :pages, local_dir: true } }
      it { should_not validate deploy: { provider: :pages, local_dir: ['str'] } }
      it { should_not validate deploy: { provider: :pages, local_dir: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, local_dir: [{:foo=>'foo'}] } }
    end

    describe 'fqdn' do
      it { should validate deploy: { provider: :pages, fqdn: 'str' } }
      it { should_not validate deploy: { provider: :pages, fqdn: 1 } }
      it { should_not validate deploy: { provider: :pages, fqdn: true } }
      it { should_not validate deploy: { provider: :pages, fqdn: ['str'] } }
      it { should_not validate deploy: { provider: :pages, fqdn: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, fqdn: [{:foo=>'foo'}] } }
    end

    describe 'project_name' do
      it { should validate deploy: { provider: :pages, project_name: 'str' } }
      it { should_not validate deploy: { provider: :pages, project_name: 1 } }
      it { should_not validate deploy: { provider: :pages, project_name: true } }
      it { should_not validate deploy: { provider: :pages, project_name: ['str'] } }
      it { should_not validate deploy: { provider: :pages, project_name: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, project_name: [{:foo=>'foo'}] } }
    end

    describe 'email' do
      it { should validate deploy: { provider: :pages, email: 'str' } }
      it { should_not validate deploy: { provider: :pages, email: 1 } }
      it { should_not validate deploy: { provider: :pages, email: true } }
      it { should_not validate deploy: { provider: :pages, email: ['str'] } }
      it { should_not validate deploy: { provider: :pages, email: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, email: [{:foo=>'foo'}] } }
    end

    describe 'name' do
      it { should validate deploy: { provider: :pages, name: 'str' } }
      it { should_not validate deploy: { provider: :pages, name: 1 } }
      it { should_not validate deploy: { provider: :pages, name: true } }
      it { should_not validate deploy: { provider: :pages, name: ['str'] } }
      it { should_not validate deploy: { provider: :pages, name: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, name: [{:foo=>'foo'}] } }
    end

    describe 'github_url' do
      it { should validate deploy: { provider: :pages, github_url: 'str' } }
      it { should_not validate deploy: { provider: :pages, github_url: 1 } }
      it { should_not validate deploy: { provider: :pages, github_url: true } }
      it { should_not validate deploy: { provider: :pages, github_url: ['str'] } }
      it { should_not validate deploy: { provider: :pages, github_url: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, github_url: [{:foo=>'foo'}] } }
    end

    describe 'keep_history' do
      it { should validate deploy: { provider: :pages, keep_history: true } }
      it { should_not validate deploy: { provider: :pages, keep_history: 1 } }
      it { should_not validate deploy: { provider: :pages, keep_history: 'str' } }
      it { should_not validate deploy: { provider: :pages, keep_history: ['str'] } }
      it { should_not validate deploy: { provider: :pages, keep_history: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, keep_history: [{:foo=>'foo'}] } }
    end

    describe 'verbose' do
      it { should validate deploy: { provider: :pages, verbose: true } }
      it { should_not validate deploy: { provider: :pages, verbose: 1 } }
      it { should_not validate deploy: { provider: :pages, verbose: 'str' } }
      it { should_not validate deploy: { provider: :pages, verbose: ['str'] } }
      it { should_not validate deploy: { provider: :pages, verbose: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, verbose: [{:foo=>'foo'}] } }
    end

    describe 'allow_empty_commit' do
      it { should validate deploy: { provider: :pages, allow_empty_commit: true } }
      it { should_not validate deploy: { provider: :pages, allow_empty_commit: 1 } }
      it { should_not validate deploy: { provider: :pages, allow_empty_commit: 'str' } }
      it { should_not validate deploy: { provider: :pages, allow_empty_commit: ['str'] } }
      it { should_not validate deploy: { provider: :pages, allow_empty_commit: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, allow_empty_commit: [{:foo=>'foo'}] } }
    end

    describe 'committer_from_gh' do
      it { should validate deploy: { provider: :pages, committer_from_gh: true } }
      it { should_not validate deploy: { provider: :pages, committer_from_gh: 1 } }
      it { should_not validate deploy: { provider: :pages, committer_from_gh: 'str' } }
      it { should_not validate deploy: { provider: :pages, committer_from_gh: ['str'] } }
      it { should_not validate deploy: { provider: :pages, committer_from_gh: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, committer_from_gh: [{:foo=>'foo'}] } }
    end

    describe 'deployment_file' do
      it { should validate deploy: { provider: :pages, deployment_file: true } }
      it { should_not validate deploy: { provider: :pages, deployment_file: 1 } }
      it { should_not validate deploy: { provider: :pages, deployment_file: 'str' } }
      it { should_not validate deploy: { provider: :pages, deployment_file: ['str'] } }
      it { should_not validate deploy: { provider: :pages, deployment_file: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :pages, deployment_file: [{:foo=>'foo'}] } }
    end
  end
end

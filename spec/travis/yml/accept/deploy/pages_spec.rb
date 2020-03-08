describe Travis::Yml, 'pages' do
  subject { described_class.load(yaml) }

  describe 'token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pages
          token:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'pages', token: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'github_token (alias)' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pages
          github_token:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'pages', token: { secure: secure }] }
      it { should have_msg [:info, :deploy, :alias_key, alias: 'github_token', key: 'token', provider: 'pages'] }
    end
  end

  describe 'github-token (dashed alias)' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pages
          github-token:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'pages', token: { secure: secure }] }
      it { should have_msg [:info, :deploy, :alias_key, alias: 'github-token', key: 'token', provider: 'pages'] }
    end
  end

  describe 'deploy_key' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          deploy_key: str
      )
      it { should serialize_to deploy: [provider: 'pages', deploy_key: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'repo' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          repo: str
      )
      it { should serialize_to deploy: [provider: 'pages', repo: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'target_branch' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          target_branch: str
      )
      it { should serialize_to deploy: [provider: 'pages', target_branch: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'local_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          local_dir: str
      )
      it { should serialize_to deploy: [provider: 'pages', local_dir: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'fqdn' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          fqdn: str
      )
      it { should serialize_to deploy: [provider: 'pages', fqdn: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'project_name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          project_name: str
      )
      it { should serialize_to deploy: [provider: 'pages', project_name: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'email' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          email: str
      )
      it { should serialize_to deploy: [provider: 'pages', email: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          name: str
      )
      it { should serialize_to deploy: [provider: 'pages', name: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'url' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          url: str
      )
      it { should serialize_to deploy: [provider: 'pages', url: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'github_url (alias)' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          github_url: str
      )
      it { should serialize_to deploy: [provider: 'pages', url: 'str'] }
      it { should have_msg [:info, :deploy, :alias_key, alias: 'github_url', key: 'url', provider: 'pages'] }
    end
  end

  describe 'keep_history' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: pages
          keep_history: false
      )
      it { should serialize_to deploy: [provider: 'pages', keep_history: false] }
      it { should_not have_msg }
    end
  end

  describe 'verbose' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: pages
          verbose: true
      )
      it { should serialize_to deploy: [provider: 'pages', verbose: true] }
      it { should_not have_msg }
    end
  end

  describe 'allow_empty_commit' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: pages
          allow_empty_commit: true
      )
      it { should serialize_to deploy: [provider: 'pages', allow_empty_commit: true] }
      it { should_not have_msg }
    end
  end

  describe 'commit_message' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          commit_message: str
      )
      it { should serialize_to deploy: [provider: 'pages', commit_message: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'committer_from_gh' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: pages
          committer_from_gh: true
      )
      it { should serialize_to deploy: [provider: 'pages', committer_from_gh: true] }
      it { should_not have_msg }
    end
  end

  describe 'deployment_file' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: pages
          deployment_file: true
      )
      it { should serialize_to deploy: [provider: 'pages', deployment_file: true] }
      it { should_not have_msg }
    end
  end
end

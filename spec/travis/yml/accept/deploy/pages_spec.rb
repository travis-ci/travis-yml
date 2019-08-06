describe Travis::Yml, 'pages' do
  subject { described_class.apply(parse(yaml)) }

  describe 'github_token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pages
          github_token:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'pages', github_token: { secure: 'secure' }] }
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

  describe 'github_url' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pages
          github_url: str
      )
      it { should serialize_to deploy: [provider: 'pages', github_url: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'no_keep_history' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: pages
          no_keep_history: true
      )
      it { should serialize_to deploy: [provider: 'pages', no_keep_history: true] }
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

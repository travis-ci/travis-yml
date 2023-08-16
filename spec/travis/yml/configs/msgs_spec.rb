describe Travis::Yml::Configs, 'msgs' do
  let(:repo) { { id: 1, github_id: 1, vcs_id: 1, slug: 'travis-ci/travis-yml' } }

  before { stub_repo(repo[:vcs_id], repo[:slug], data: { internal: true, body: repo.merge(token: 'token') }) }
  before { stub_content(repo[:id], '.travis.yml', yaml) }

  subject { described_class.new(repo, 'master', nil, {}, opts).tap(&:load) }

  describe 'merge_normalized not given' do
    describe 'defaults', defaults: true do
      yaml ''
      it { expect(subject.config).to eq defaults }
      it { should have_msg [:info, :root, :default, key: 'language', default: 'ruby'] }
      it { should have_msg [:info, :root, :default, key: 'os', default: 'linux'] }
      it { should have_msg [:info, :root, :default, key: 'dist', default: 'xenial'] }
    end

    describe 'empty', empty: true do
      yaml 'script:'
      it { expect(subject.config).to eq script: [] }
      it { should have_msg [:warn, :script, :empty, key: 'script'] }
    end

    describe 'unknown' do
      yaml %(
        unknown: str
      )
      it { expect(subject.config).to eq unknown: 'str' }
      it { should have_msg [:warn, :root, :unknown_key, key: 'unknown', value: 'str'] }
    end

    describe 'alert', alert: true do
      yaml %(
        deploy:
          - provider: pages
            token: str
      )
      it { expect(subject.config).to eq deploy: [provider: 'pages', token: 'str'] }
      it { should have_msg [:alert, :'deploy.token', :secure, type: :str] }
    end
  end

  describe 'merge_normalized given', merge_normalized: true do
    describe 'defaults', defaults: true do
      yaml ''
      it { expect(subject.config).to eq defaults }
      it { should have_msg [:info, :root, :default, key: 'language', default: 'ruby'] }
      it { should have_msg [:info, :root, :default, key: 'os', default: 'linux'] }
      it { should have_msg [:info, :root, :default, key: 'dist', default: 'xenial'] }
    end

    describe 'empty', empty: true do
      yaml 'script:'
      it { expect(subject.config).to eq script: [] }
      it { should have_msg [:warn, :script, :empty, key: 'script'] }
    end

    describe 'unknown' do
      yaml %(
        unknown: str
      )
      it { expect(subject.config).to eq unknown: 'str' }
      it { should have_msg [:warn, :root, :unknown_key, key: 'unknown', value: 'str'] }
    end

    describe 'alert', alert: true do
      yaml %(
        deploy:
          - provider: pages
            token: str
      )
      it { expect(subject.config).to eq deploy: [provider: 'pages', token: 'str'] }
      it { should have_msg [:alert, :'deploy.token', :secure, type: :str] }
    end
  end
end

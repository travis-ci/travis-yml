describe Travis::Yml::Configs do
  let(:user_token) { nil }
  let(:internal) { false }
  let(:repo)    { { slug: 'travis-ci/travis-yml', private: private, default_branch: 'master', token: 'repo_token', private_key: 'private_key', allow_config_imports: true } }
  let(:opts)    { { token: user_token, internal: internal } }
  let(:configs) { described_class.new(repo, 'ref', nil, nil, nil, opts) }

  let(:travis_yml) { 'language: shell' }

  before { stub_repo(repo[:slug], token: user_token, status: status) }
  before { stub_content(repo[:slug], '.travis.yml', travis_yml) }

  subject { configs.tap(&:load) }

  describe 'unauthenticated' do
    let(:user_token) { nil }

    describe 'a public repo' do
      let(:private) { false }
      let(:status) { 200 }
      it { expect { subject }.to_not raise_error }
      it { expect { subject }.to_not have_api_request :get, 'repo/travis-ci%2Ftravis-yml' }
    end

    describe 'a private repo' do
      let(:private) { true }
      let(:status) { 401 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthenticated }
      it { expect { subject}.to_not have_api_request :get, 'repo/travis-ci%2Ftravis-yml' }
    end
  end

  describe 'authenticated as user' do
    let(:user_token) { 'user-token' }

    describe 'a public repo' do
      let(:private) { false }
      let(:status) { 200 }
      it { subject }
      it { expect { subject }.to_not raise_error }
    end

    describe 'a private repo' do
      describe 'given a valid token' do
        let(:private) { true }
        let(:status) { 200 }
        it { expect { subject }.to_not raise_error }
        it { expect { subject }.to have_api_request :get, 'repo/travis-ci%2Ftravis-yml', token: user_token }
      end

      describe 'given an invalid token' do
        let(:private) { true }
        let(:status) { 401 }
        it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthorized }
        it { expect { subject }.to have_api_request :get, 'repo/travis-ci%2Ftravis-yml', token: user_token }
      end
    end
  end

  describe 'authenticated as internal' do
    let(:internal) { true }

    describe 'a public repo' do
      let(:private) { false }
      let(:status) { 200 }
      it { subject }
      it { expect { subject }.to_not raise_error }
      it { expect { subject }.to_not have_api_request :get, 'repo/travis-ci%2Ftravis-yml' }
    end

    describe 'a private repo' do
      let(:private) { true }
      let(:status) { 200 }
      it { subject }
      it { expect { subject }.to_not raise_error }
      it { expect { subject }.to_not have_api_request :get, 'repo/travis-ci%2Ftravis-yml' }
    end
  end
end

describe Travis::Yml::Configs do
  let(:private_key) { PRIVATE_KEYS[:one] }
  let(:repo_token) { 'repo-token' }
  let(:user_token) { 'user-token' }
  let(:private) { false }
  let(:imports) { true }
  let(:repo)    { { github_id: 1, slug: 'travis-ci/travis-yml', private: private, default_branch: 'master', token: repo_token, private_key: private_key, allow_config_imports: imports } }
  let(:ref)     { 'ref' }
  let(:raw)     { nil }
  let(:data)    { nil }
  let(:mode)    { nil }
  let(:opts)    { { token: user_token, data: data } }
  let(:configs) { described_class.new(repo, ref, raw, mode, data, opts) }
  let(:config)  { subject.config }
  let(:jobs)    { subject.jobs }
  let(:stages)  { subject.stages }
  let(:msgs)    { subject.msgs.to_a }
  let(:setting) { true }

  let(:travis_yml) { 'import: one/one.yml' }
  let(:one_yml)    { 'script: ./one' }
  let(:two_yml)    { 'script: ./two' }

  before { stub_repo(repo[:slug], token: user_token) } # authorization
  before { stub_content(repo[:github_id], '.travis.yml', travis_yml) }
  before { stub_content(repo[:github_id], 'one/one.yml', one_yml) }
  before { stub_content(repo[:github_id], 'one/two.yml', two_yml) }

  subject { configs.tap(&:load) }

  def self.imports(sources)
    it { expect(subject.map(&:to_s)).to eq sources }
  end

  describe 'push' do
    let(:repo_url) { "repo/#{repo[:slug].sub('/', '%2F')}?representation=internal" }
    let(:auth_url) { "repo/#{repo[:slug].sub('/', '%2F')}" }

    describe 'given a repo token' do
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
        travis-ci/travis-yml:one/one.yml@ref
      )
      it { expect { subject }.to_not have_api_request :get, repo_url }
      it { expect { subject }.to_not have_api_request :get, repo_url }
    end

    describe 'not given a repo token on a public repo' do
      let(:repo_token) { nil }
      let(:private) { false }
      before { stub_repo(repo[:slug], internal: true, body: repo.merge(token: repo_token)) }
      it { expect { subject }.to_not have_api_request :get, repo_url }
      it { expect { subject }.to_not have_api_request :get, auth_url }
    end

    describe 'not given a repo token on a private repo' do
      let(:repo_token) { nil }
      let(:private) { true }
      before { stub_repo(repo[:slug], internal: true, body: repo.merge(token: repo_token)) }
      it { expect { subject }.to have_api_request :get, repo_url }
      it { expect { subject }.to have_api_request :get, auth_url, token: user_token }
    end
  end

  describe 'api' do
    describe 'by default (imports .travis.yml)' do
      let(:raw) { 'script: ./api' }

      imports %w(
        api
        travis-ci/travis-yml:.travis.yml@ref
        travis-ci/travis-yml:one/one.yml@ref
      )
    end

    describe 'given imports (skips .travis.yml)' do
      let(:raw) { 'import: one/one.yml' }

      imports %w(
        api
        travis-ci/travis-yml:one/one.yml@ref
      )
    end

    describe 'merge_mode replace (skips all)' do
      let(:raw) { 'import: one/one.yml' }
      let(:mode) { :replace }

      imports %w(
        api
      )
    end
  end

  describe 'remote import' do
    let(:travis_yml) { 'import: other/other:one.yml' }

    before { stub_repo('other/other', internal: true, body: { github_id: 2, private: false, default_branch: 'default' }) }
    before { stub_content(2, 'one.yml', one_yml) }
    before { stub_content(2, 'two.yml', one_yml) }

    describe "defaults the repo to the parent config's repo" do
      let(:one_yml) { 'import: two.yml@master' }

      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
        other/other:one.yml@default
        other/other:two.yml@master
      )
    end

    describe 'defaults the ref to the repo default branch' do
      let(:one_yml) { 'import: other/other:two.yml' }

      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
        other/other:one.yml@default
        other/other:two.yml@default
      )
    end
  end

  describe 'reencrypt' do
    before { stub_repo('travis-ci/other', internal: true, body: { github_id: 1, private: private, default_branch: 'default', config_imports: true, private_key: PRIVATE_KEYS[:two] }) }
    before { stub_repo('other/other', internal: true, body: { github_id: 2, private: private, default_branch: 'default', config_imports: true, private_key: PRIVATE_KEYS[:two] }) }
    before { stub_content(1, 'one.yml', one_yml) }
    before { stub_content(2, 'one.yml', one_yml) }

    let(:encrypted) { encrypt('secret') }
    let(:one_yml) { "env:\n  - secure: '#{encrypted}'" }
    let(:var) { (subject.config.dig(:env, :jobs)&.first || {})[:secure] }

    describe 'local config' do
      let(:private) { false }
      let(:travis_yml) { 'import: one/one.yml' }
      before { expect_any_instance_of(Travis::Yml::Configs::Model::Repo).to receive(:reencrypt).never }
      it { subject }
    end

    describe 'same owner' do
      describe 'public config' do
        let(:travis_yml) { 'import: travis-ci/other:one.yml' }
        let(:private) { false }
        it { expect(var).to_not eq encrypted }
        it { expect(decrypt(var)).to eq 'secret' }
      end

      describe 'private config on the same owner' do
        let(:travis_yml) { 'import: travis-ci/other:one.yml' }
        let(:private) { true }
        it { expect(var).to_not eq encrypted }
        it { expect(decrypt(var)).to eq 'secret' }
      end
    end

    describe 'foreign owner' do
      describe 'public config' do
        let(:travis_yml) { 'import: other/other:one.yml' }
        let(:private) { false }
        it { expect(var).to eq encrypted }
        it { expect { decrypt(var) }.to raise_error OpenSSL::OpenSSLError }
      end

      describe 'private config on the same owner' do
        let(:travis_yml) { 'import: other/other:one.yml' }
        let(:private) { true }
        it { expect(var).to be_nil }
      end
    end

    def decrypt(str)
      key = OpenSSL::PKey::RSA.new(PRIVATE_KEYS[:one])
      key.private_decrypt(Base64.decode64(str))
    end

    def encrypt(str)
      key = OpenSSL::PKey::RSA.new(PRIVATE_KEYS[:two])
      Base64.strict_encode64(key.public_encrypt(str))
    end
  end

  describe 'expanding relative paths (local)' do
    let(:one_yml) { 'import: ./two.yml' }

    imports %w(
      travis-ci/travis-yml:.travis.yml@ref
      travis-ci/travis-yml:one/one.yml@ref
      travis-ci/travis-yml:one/two.yml@ref
    )
  end

  describe 'expanding relative paths (remote)' do
    let(:travis_yml) { 'import: other/other:one/one.yml' }
    let(:one_yml) { 'import: ./two.yml' }

    before { stub_repo('other/other', internal: true, body: { github_id: 2, default_branch: 'default' }) }
    before { stub_content(2, 'one/one.yml', one_yml) }
    before { stub_content(2, 'one/two.yml', two_yml) }

    imports %w(
      travis-ci/travis-yml:.travis.yml@ref
      other/other:one/one.yml@default
      other/other:one/two.yml@default
    )
  end

  describe 'given a merge_mode' do
    let(:travis_yml) do
      <<~yml
        import:
          - source: one/one.yml
            mode: merge
      yml
    end

    let(:one_yml) do
      <<~yml
        import:
          - source: one/two.yml
            mode: deep_merge
      yml
    end

    it { expect(subject.map(&:mode)).to eq [nil, :merge, :deep_merge] }
  end

  describe 'conditional imports' do
    let(:travis_yml) do
      <<~yml
        import:
          - source: one/one.yml
            if: type = push
          - source: one/two.yml
            if: type = pull_request
      yml
    end

    let(:data) { { type: 'push' } }

    imports %w(
      travis-ci/travis-yml:.travis.yml@ref
      travis-ci/travis-yml:one/one.yml@ref
    )

    it { expect(msgs).to include [:info, :import, :skip_import, source: 'travis-ci/travis-yml:one/two.yml@ref', condition: 'type = pull_request'] }
  end

  describe 'visibility' do
    let(:repo) { { slug: 'travis-ci/travis-yml', private: visibilities[0] == :private, token: repo_token, private_key: private_key, allow_config_imports: imports } }
    let(:travis_yml) { "import: #{other}:one.yml" }

    before { stub_repo(repo[:slug], internal: true, body: repo.merge(token: repo_token)) }
    before { stub_repo(other, internal: true, body: { github_id: 2, slug: other, private: visibilities[1] == :private, config_imports: setting }) }
    before { stub_content(2, 'one.yml', one_yml) }

    describe 'a public repo referencing a public repo' do
      let(:other) { 'other/other' }
      let(:visibilities) { [:public, :public] }
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
        other/other:one.yml@master
      )
    end

    describe 'a public repo referencing a private repo' do
      let(:other) { 'other/other' }
      let(:visibilities) { [:public, :private] }
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
      )
      it { should have_msg [:error, :import, :invalid_visibility, repo: 'other/other'] }
    end

    describe 'a private repo referencing a public repo from the same owner' do
      let(:other) { 'travis-ci/other' }
      let(:visibilities) { [:private, :public] }
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
        travis-ci/other:one.yml@master
      )
    end

    describe 'a private repo referencing a public repo from another owner' do
      let(:other) { 'other/other' }
      let(:visibilities) { [:private, :public] }
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
        other/other:one.yml@master
      )
    end

    describe 'a private repo referencing a private repo from the same owner (setting: true)' do
      let(:other) { 'travis-ci/other' }
      let(:visibilities) { [:private, :private] }
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
        travis-ci/other:one.yml@master
      )
    end

    describe 'a private repo referencing a private repo from the same owner (setting: false)' do
      let(:other) { 'travis-ci/other' }
      let(:visibilities) { [:private, :private] }
      let(:setting) { false }
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
      )
      it { should have_msg [:error, :import, :import_not_allowed, repo: 'travis-ci/other'] }
    end

    describe 'a private repo referencing a private repo from another owner' do
      let(:other) { 'other/other' }
      let(:visibilities) { [:private, :private] }
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
      )
      it { should have_msg [:error, :import, :invalid_ownership, owner: 'other'] }
    end
  end

  describe 'cyclic imports (1)' do
    let(:travis_yml) { 'import: .travis.yml' }

    imports %w(
      travis-ci/travis-yml:.travis.yml@ref
    )
  end

  describe 'cyclic imports (2)' do
    let(:one_yml) { 'import: ./two.yml' }
    let(:two_yml) { 'import: ./one.yml' }

    imports %w(
      travis-ci/travis-yml:.travis.yml@ref
      travis-ci/travis-yml:one/one.yml@ref
      travis-ci/travis-yml:one/two.yml@ref
    )
  end

  describe 'cyclic imports (3)' do
    let(:one_yml) { 'import: .travis.yml' }
    imports %w(
      travis-ci/travis-yml:.travis.yml@ref
      travis-ci/travis-yml:one/one.yml@ref
    )
  end

  describe 'malformed ref (skips the import, outputs a validation message)' do
    let(:travis_yml) { 'import: invalid' }

    imports %w(
      travis-ci/travis-yml:.travis.yml@ref
    )

    it { should have_msg [:error, :import, :invalid_ref, ref: 'invalid'] }
  end

  describe 'unknown repo' do
    let(:travis_yml) { 'import: unknown/unknown:one.yml@v1' }
    let(:error) { Travis::Yml::Configs::UnknownRepo }
    xit { expect { configs }.to raise_error(error) }
  end

  describe 'duplicate imports' do
    let(:error) { Travis::Yml::Configs::TooManyImports }
    let(:travis_yml) { "import: \n#{1.upto(5).map { |i| "- one/one.yml" }.join("\n")}" }

    imports %w(
      travis-ci/travis-yml:.travis.yml@ref
      travis-ci/travis-yml:one/one.yml@ref
    )
  end

  describe 'too many imports' do
    let(:error) { Travis::Yml::Configs::TooManyImports }
    let(:travis_yml) { "import: \n#{1.upto(30).map { |i| "- #{i}.yml" }.join("\n")}" }
    before { 1.upto(30) { |i| stub_content(repo[:github_id], "#{i}.yml", "script: .#{i}.sh") } }

    it { expect(subject.to_a.size).to eq 25 }
    it { should have_msg [:error, :import, :too_many_imports, max: 25] }
  end

  describe 'import order is depth first' do
    let(:repo) { { github_id: 1, slug: 'owner/repo', token: repo_token, private: true } }
    let(:travis_yml) { 'import: [.travis.yml, 1.yml]' }
    let(:y1) { 'import: [2.yml, 5.yml, 6.yml]' }
    let(:y2) { 'import: [3.yml]' }
    let(:y3) { 'import: [4.yml, 1.yml]' }
    let(:y4) { 'script: ./4' }
    let(:y5) { 'script: ./5' }
    let(:y6) { 'script: ./6' }

    before { stub_repo(repo[:slug], internal: true, body: repo) }
    before { stub_content(repo[:github_id], '.travis.yml', travis_yml) }
    before { 1.upto(6) { |i| stub_content(repo[:github_id], "#{i}.yml", send(:"y#{i}")) } }

    subject { configs.tap(&:load).map(&:to_s) }

    it do
      should eq %w(
        owner/repo:.travis.yml@ref
        owner/repo:1.yml@ref
        owner/repo:2.yml@ref
        owner/repo:3.yml@ref
        owner/repo:4.yml@ref
        owner/repo:5.yml@ref
        owner/repo:6.yml@ref
      )
    end
  end
end

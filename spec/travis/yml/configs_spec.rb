describe Travis::Yml::Configs do
  let(:private_key) { PRIVATE_KEYS[:one] }
  let(:repo_token) { 'repo-token' }
  let(:user_token) { 'user-token' }
  let(:private) { false }
  let(:imports) { true }
  let(:repo)    { { slug: 'travis-ci/travis-yml', private: private, default_branch: 'master', token: repo_token, private_key: private_key, allow_config_imports: imports } }
  let(:ref)     { 'ref' }
  let(:config)  { nil }
  let(:data)    { nil }
  let(:mode)    { nil }
  let(:opts)    { { token: user_token, data: data } }
  let(:configs) { described_class.new(repo, ref, config, mode, data, opts) }
  let(:msgs)    { subject.msgs.to_a }
  let(:jobs)    { subject.jobs }
  let(:stages)  { subject.stages }
  let(:setting) { true }

  let(:travis_yml) { 'import: one/one.yml' }
  let(:one_yml)    { 'script: ./one' }
  let(:two_yml)    { 'script: ./two' }

  before { stub_repo(repo[:slug], token: user_token) } # authorization
  before { stub_content(repo[:slug], '.travis.yml', travis_yml) }
  before { stub_content(repo[:slug], 'one/one.yml', one_yml) }
  before { stub_content(repo[:slug], 'one/two.yml', two_yml) }

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
      it { expect { subject }.to have_api_request :get, repo_url }
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
      let(:config) { 'script: ./api' }

      imports %w(
        api
        travis-ci/travis-yml:.travis.yml@ref
        travis-ci/travis-yml:one/one.yml@ref
      )
    end

    describe 'given imports (skips .travis.yml)' do
      let(:config) { 'import: one/one.yml' }

      imports %w(
        api
        travis-ci/travis-yml:one/one.yml@ref
      )
    end

    describe 'merge_mode replace (skips all)' do
      let(:config) { 'import: one/one.yml' }
      let(:mode) { :replace }

      imports %w(
        api
      )
    end
  end

  describe 'remote import' do
    let(:travis_yml) { 'import: other/other:one.yml' }

    before { stub_content('other/other', 'one.yml', one_yml) }
    before { stub_content('other/other', 'two.yml', one_yml) }
    before { stub_repo('other/other', internal: true, body: { private: false, default_branch: 'default' }) }

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
    before { stub_repo('travis-ci/other', internal: true, body: { private: private, default_branch: 'default', config_imports: true, private_key: PRIVATE_KEYS[:two] }) }
    before { stub_repo('other/other', internal: true, body: { private: private, default_branch: 'default', config_imports: true, private_key: PRIVATE_KEYS[:two] }) }
    before { stub_content('travis-ci/other', 'one.yml', one_yml) }
    before { stub_content('other/other', 'one.yml', one_yml) }

    let(:encrypted) { encrypt('secret') }
    let(:one_yml) { "env:\n  - secure: '#{encrypted}'" }
    let(:var) { subject.config[:env][:jobs][0][:secure] }

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
        it { expect { subject }.to raise_error Travis::Yml::Configs::Errors::InvalidOwnership }
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

    before { stub_content('other/other', 'one/one.yml', one_yml) }
    before { stub_content('other/other', 'one/two.yml', two_yml) }
    before { stub_repo('other/other', internal: true, body: { default_branch: 'default' }) }

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

  describe 'given a condition' do
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

    before { stub_content(other, 'one.yml', one_yml) }
    before { stub_repo(other, internal: true, body: { private: visibilities[1] == :private, config_imports: setting }) }

    describe 'a public repo referencing a public repo' do
      let(:other) { 'other/other' }
      let(:visibilities) { [:public, :public] }
      it { expect { subject }.to_not raise_error }
    end

    describe 'a public repo referencing a private repo' do
      let(:error) { Travis::Yml::Configs::InvalidVisibility }
      let(:other) { 'other/other' }
      let(:visibilities) { [:public, :private] }
      it { expect { subject }.to raise_error error }
    end

    describe 'a private repo referencing a public repo from the same owner' do
      let(:other) { 'travis-ci/other' }
      let(:visibilities) { [:private, :public] }
      it { expect { subject }.to_not raise_error }
    end

    describe 'a private repo referencing a public repo from another owner' do
      let(:other) { 'other/other' }
      let(:visibilities) { [:private, :public] }
      it { expect { subject }.to_not raise_error }
    end

    describe 'a private repo referencing a private repo from the same owner (setting: true)' do
      let(:other) { 'travis-ci/other' }
      let(:visibilities) { [:private, :private] }
      it { expect { subject }.to_not raise_error }
    end

    describe 'a private repo referencing a private repo from the same owner (setting: false)' do
      let(:other) { 'travis-ci/other' }
      let(:visibilities) { [:private, :private] }
      let(:setting) { false }
      let(:error) { Travis::Yml::Configs::NotAllowed }
      it { expect { subject }.to raise_error error }
    end

    describe 'a private repo referencing a private repo from another owner' do
      let(:other) { 'other/other' }
      let(:visibilities) { [:private, :private] }
      let(:error) { Travis::Yml::Configs::InvalidOwnership }
      it { expect { subject }.to raise_error error }
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
    let(:travis_yml) { 'import: "@v1"' }
    let(:error) { Travis::Yml::Configs::InvalidRef }
    it { expect { subject }.to raise_error(error) }
  end

  describe 'unknown repo' do
    let(:travis_yml) { 'import: unknown/unknown:one.yml@v1' }
    let(:error) { Travis::Yml::Configs::UnknownRepo }
    xit { expect { configs }.to raise_error(error) }
  end

  describe 'too many imports' do
    let(:error) { Travis::Yml::Configs::TooManyImports }
    let(:travis_yml) { "import: \n#{1.upto(30).map { |i| "- #{i}.yml" }.join("\n")}" }
    before { 1.upto(30) { |i| stub_content(repo[:slug], "#{i}.yml", '') } }
    it { expect { subject }.to raise_error(error) }
  end

  describe 'github api errors' do
    before { stub_content(repo[:slug], 'one/one.yml', status: status) }

    describe '401' do
      let(:status) { 401 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthorized }
    end

    describe '404' do
      let(:status) { 404 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::NotFound }
    end

    describe '500' do
      let(:status) { 500 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::ServerError }
    end
  end

  describe 'travis api errors' do
    let(:travis_yml) { 'import: other/other:one.yml' }

    before { stub_content('other/other', 'one.yml', one_yml) }
    before { stub_repo('other/other', internal: true, status: status) }

    describe '401' do
      let(:status) { 401 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::Unauthorized }
    end

    describe '404' do
      let(:status) { 404 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::NotFound }
    end

    describe '500' do
      let(:status) { 500 }
      it { expect { subject }.to raise_error Travis::Yml::Configs::ServerError }
    end
  end

  describe 'import order is depth first' do
    let(:repo) { { slug: 'owner/repo', token: repo_token, private: true } }
    let(:travis_yml) { 'import: [.travis.yml, 1.yml]' }
    let(:y1) { 'import: [2.yml, 5.yml, 6.yml]' }
    let(:y2) { 'import: [3.yml]' }
    let(:y3) { 'import: [4.yml, 1.yml]' }
    let(:y4) { 'script: ./4' }
    let(:y5) { 'script: ./5' }
    let(:y6) { 'script: ./6' }

    before { stub_content(repo[:slug], '.travis.yml', travis_yml) }
    before { stub_repo(repo[:slug], internal: true, body: repo) }
    before { 1.upto(6) { |i| stub_content(repo[:slug], "#{i}.yml", send(:"y#{i}")) } }

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

  describe 'stages and allow_failures' do
    let(:travis_yml) { yaml }

    describe 'no stages section' do
      yaml %(
        jobs:
          include:
            - name: one
              stage: one
            - name: two
            - name: three
              stage: two
            - name: four
          allow_failures:
            - name: one
            - name: four
      )

      it do
        expect(stages).to eq [
          { name: 'One' },
          { name: 'Two' }
        ]
      end

      it do
        expect(jobs).to eq [
          { name: 'two',   stage: 'One' },
          { name: 'one',   stage: 'One', allow_failure: true },
          { name: 'three', stage: 'Two' },
          { name: 'four',  stage: 'Two', allow_failure: true }
        ]
      end
    end

    describe 'no stages section' do
      yaml %(
        stages:
          - one
          - two
        jobs:
          include:
            - name: three
              stage: two
            - name: four
            - name: two
              stage: one
            - name: one
            - name: six
              stage: three
            - name: five
          allow_failures:
            - name: two
            - name: four
            - name: six
      )

      it do
        expect(stages).to eq [
          { name: 'One' },
          { name: 'Two' },
          { name: 'Three' }
        ]
      end

      it do
        expect(jobs).to eq [
          { name: 'one',   stage: 'One' },
          { name: 'two',   stage: 'One', allow_failure: true },
          { name: 'three', stage: 'Two' },
          { name: 'four',  stage: 'Two', allow_failure: true },
          { name: 'five',  stage: 'Three' },
          { name: 'six',   stage: 'Three', allow_failure: true }
        ]
      end
    end
  end
end

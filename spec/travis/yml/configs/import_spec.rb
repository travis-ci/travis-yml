describe Travis::Yml::Configs do
  let(:private_key) { PRIVATE_KEYS[:one] }
  let(:repo_token) { 'repo-token' }
  let(:user_token) { 'user-token' }
  let(:private) { false }
  let(:imports) { true }
  let(:repo)    { { id: 1, github_id: 1, slug: 'travis-ci/travis-yml', private: private, default_branch: 'master', token: repo_token, private_key: private_key, allow_config_imports: imports } }
  let(:ref)     { 'ref' }
  let(:api)     { nil }
  let(:data)    { nil }
  let(:mode)    { nil }
  let(:configs) { described_class.new(repo, ref, api ? [config: api, mode: mode&.to_s] : nil, data, opts.merge(token: user_token, data: data)) }
  let(:config)  { subject.config }
  let(:jobs)    { subject.jobs }
  let(:stages)  { subject.stages }
  let(:msgs)    { subject.msgs.to_a }
  let(:setting) { true }

  let(:travis_yml) { "import: one/one.yml\nscript: ./travis" }
  let(:one_yml)    { 'script: ./one' }
  let(:two_yml)    { 'script: ./two' }

  before { stub_repo(repo[:slug], token: user_token) } # authorization
  before { stub_content(repo[:id], '.travis.yml', travis_yml) }
  before { stub_content(repo[:id], 'one/one.yml', one_yml) }
  before { stub_content(repo[:id], 'one/two.yml', two_yml) }
  before { stub_content(repo[:id], 'one.yml', one_yml) }
  before { stub_content(repo[:id], 'two.yml', two_yml) }

  subject { configs.tap(&:load) }

  def self.imports(sources)
    it { expect(subject.map(&:to_s)).to eq sources }
  end

  describe 'push' do
    let(:repo_url) { "repo/github/#{repo[:slug].sub('/', '%2F')}?representation=internal" }
    let(:auth_url) { "repo/github/#{repo[:slug].sub('/', '%2F')}" }

    describe 'given a repo token' do
      imports %w(
        travis-ci/travis-yml:.travis.yml@ref
        travis-ci/travis-yml:one/one.yml@ref
      )
      it { expect { subject }.to_not have_api_request :get, repo_url }
    end

    describe 'not given a repo token on a public repo' do
      let(:repo_token) { nil }
      let(:private) { false }
      before { stub_repo(repo[:slug], internal: true, body: repo.merge(token: repo_token)) }
      it { expect { subject }.to_not have_api_request :get, repo_url }
    end

    describe 'not given a repo token on a private repo' do
      let(:repo_token) { nil }
      let(:private) { true }
      before { stub_repo(repo[:slug], internal: true, body: repo.merge(token: repo_token)) }
      it { expect { subject }.to have_api_request :get, repo_url }
    end
  end

  describe 'api' do
    describe 'by default (imports .travis.yml)' do
      let(:api) { 'script: ./api' }
      let(:mode) { :deep_merge_append }

      imports %w(
        api
        travis-ci/travis-yml:.travis.yml@ref
        travis-ci/travis-yml:one/one.yml@ref
      )

      describe 'merge_normalized turned off' do
        it do
          should serialize_to(
            script: %w(./api)
          )
        end
      end

      describe 'merge_normalized turned on', merge_normalized: true do
        it do
          should serialize_to(
            script: %w(./one ./travis ./api)
          )
        end
      end
    end

    describe 'given imports' do
      let(:api) { "import: one/one.yml\nscript: ./api" }
      let(:mode) { :deep_merge_append }

      imports %w(
        api
        travis-ci/travis-yml:one/one.yml@ref
        travis-ci/travis-yml:.travis.yml@ref
      )

      describe 'merge_normalized turned off' do
        it do
          should serialize_to(
            script: %w(./api)
          )
        end
      end

      describe 'merge_normalized turned on', merge_normalized: true do
        it do
          should serialize_to(
            script: %w(./travis ./one ./api)
          )
        end
      end
    end

    describe 'merge_mode replace (skips .travis.yml, but keeps the import)' do
      let(:api) { "import: one/one.yml\nscript: ./api" }
      let(:mode) { :replace }

      imports %w(
        api
        travis-ci/travis-yml:one/one.yml@ref
      )

      describe 'merge_normalized turned off' do
        it do
          should serialize_to(
            script: %w(./api)
          )
        end
      end

      describe 'merge_normalized turned on', merge_normalized: true do
        it do
          should serialize_to(
            script: %w(./one ./api)
          )
        end
      end
    end
  end

  describe 'remote import' do
    let(:travis_yml) { 'import: other/other:one.yml' }

    before { stub_repo('other/other', internal: true, body: { id: 2, github_id: 2, private: false, default_branch: 'default' }) }
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

    before { stub_repo('other/other', internal: true, body: { id: 2, github_id: 2, default_branch: 'default' }) }
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

    it { expect(subject.map(&:merge_modes)).to eq [{ lft: :deep_merge_append }, { lft: 'merge' }, { lft: 'deep_merge' }] }
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
    let(:repo) { { id: 1, slug: 'travis-ci/travis-yml', private: visibilities[0] == :private, token: repo_token, private_key: private_key, allow_config_imports: imports } }
    let(:travis_yml) { "import: #{other}:one.yml" }

    before { stub_repo(repo[:slug], internal: true, body: repo.merge(token: repo_token)) }
    before { stub_repo(other, internal: true, body: { id: 2, github_id: 2, slug: other, private: visibilities[1] == :private, config_imports: setting }) }
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
    before { 1.upto(30) { |i| stub_content(repo[:id], "#{i}.yml", "script: .#{i}.sh") } }

    it { expect(subject.to_a.size).to eq 25 }
    it { should have_msg [:error, :import, :too_many_imports, max: 25] }
  end

  describe 'import order is depth first' do
    let(:repo) { { id: 1, github_id: 1, slug: 'owner/repo', token: repo_token, private: true } }
    let(:travis_yml) { 'import: [.travis.yml, 1.yml]' }
    let(:y1) { 'import: [2.yml, 5.yml, 6.yml]' }
    let(:y2) { 'import: [3.yml]' }
    let(:y3) { 'import: [4.yml, 1.yml]' }
    let(:y4) { 'script: ./4' }
    let(:y5) { 'script: ./5' }
    let(:y6) { 'script: ./6' }

    before { stub_repo(repo[:slug], internal: true, body: repo) }
    before { stub_content(repo[:id], '.travis.yml', travis_yml) }
    before { 1.upto(6) { |i| stub_content(repo[:id], "#{i}.yml", send(:"y#{i}")) } }

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

  describe do
    let(:repo) { { id: 1, github_id: 1, slug: 'owner/repo', token: repo_token, private: true } }

    let(:travis_yml) do
      <<~yml
        script:
        - ./travis_yml
        import:
        - source: one.yml
          mode: #{mode}
        - source: two.yml
          mode: #{mode}
      yml
    end

    let(:one) do
      <<~yml
        script:
        - ./one
        import:
        - source: nested.yml
          mode: #{mode}
      yml
    end

    let(:two) do
      <<~yml
        script:
        - ./two
        import:
        - source: nested.yml
          mode: #{mode}
      yml
    end

    let(:nested) do
      <<~yml
        script:
        - ./nested
      yml
    end

    before { stub_repo(repo[:slug], internal: true, body: repo) }
    before { stub_content(repo[:id], '.travis.yml', travis_yml) }
    before { stub_content(repo[:id], 'one.yml', one) }
    before { stub_content(repo[:id], 'two.yml', two) }
    before { stub_content(repo[:id], 'nested.yml', nested) }
    before { configs.tap(&:load) }

    describe 'deep_merge_append' do
      let(:mode) { :deep_merge_append }

      it do
        expect(configs.config).to eq(
          script: %w(
            ./nested
            ./two
            ./one
            ./travis_yml
          )
        )
      end
    end

    describe 'deep_merge_prepend' do
      let(:mode) { :deep_merge_prepend }

      it do
        expect(configs.config).to eq(
          script: %w(
            ./travis_yml
            ./one
            ./two
            ./nested
          )
        )
      end
    end
  end
end

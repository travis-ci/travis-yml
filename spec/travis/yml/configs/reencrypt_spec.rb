describe Travis::Yml::Configs do
  let(:repo)    { { github_id: 1, slug: 'travis-ci/travis-yml', private: private, default_branch: 'master', token: 'repo-token', private_key: PRIVATE_KEYS[:one], allow_config_imports: true } }
  let(:configs) { described_class.new(repo, 'ref', nil, nil, opts.merge(token: 'user-token')) }

  subject { configs.tap(&:load) }

  def decrypt(key, strs)
    key = OpenSSL::PKey::RSA.new(PRIVATE_KEYS[key])
    strs.map { |str| key.private_decrypt(Base64.decode64(str)) }
  end

  def encrypt(key, str)
    key = OpenSSL::PKey::RSA.new(PRIVATE_KEYS[key])
    Base64.strict_encode64(key.public_encrypt(str))
  end

  before { stub_repo('travis-ci/travis-yml', token: 'user-token') } # authorization
  before { stub_repo('travis-ci/other', internal: true, body: { github_id: 2, private: private, default_branch: 'default', config_imports: true, private_key: PRIVATE_KEYS[:two] }) }
  before { stub_repo('other/other', internal: true, body: { github_id: 3, private: private, default_branch: 'default', config_imports: true, private_key: PRIVATE_KEYS[:two] }) }

  before { stub_content(1, '.travis.yml', travis_yml) }
  before { stub_content(1, 'one.yml', one_yml) }
  before { stub_content(2, 'one.yml', one_yml) }
  before { stub_content(3, 'one.yml', one_yml) }
  before { stub_content(1, 'two.yml', two_yml) if defined?(two_yml) }
  before { stub_content(2, 'two.yml', two_yml) if defined?(two_yml) }
  before { stub_content(3, 'two.yml', two_yml) if defined?(two_yml) }

  let(:vars) { (subject.config.dig(:env, :global) || []).map { |var| var[:secure] } }

  describe 'importing a secret from a config' do
    let(:one_yml) do
      %(
        env:
          global:
            - secure: #{one}
      )
    end

    describe 'from the same repo' do
      let(:private) { false }
      let(:travis_yml) { 'import: one.yml' }
      let(:one) { encrypt(:one, 'secret_one') }

      before { expect_any_instance_of(Travis::Yml::Configs::Model::Repo).to receive(:reencrypt).never }

      it { expect(vars).to eq [one] }
      it { expect(decrypt(:one, vars)).to eq %w(secret_one) }
    end

    describe 'from the same owner' do
      let(:one) { encrypt(:two, 'secret_one') }

      describe 'public config' do
        let(:travis_yml) { 'import: travis-ci/other:one.yml' }
        let(:private) { false }
        it { expect(vars).to_not eq [one] }
        it { expect(decrypt(:one, vars)).to eq %w(secret_one) }
      end

      describe 'private config on the same owner' do
        let(:travis_yml) { 'import: travis-ci/other:one.yml' }
        let(:private) { true }
        it { expect(vars).to_not eq [one] }
        it { expect(decrypt(:one, vars)).to eq %w(secret_one) }
      end
    end

    describe 'from another owner' do
      let(:one) { encrypt(:two, 'secret_one') }

      describe 'public config' do
        let(:travis_yml) { 'import: other/other:one.yml' }
        let(:private) { false }
        it { expect(vars).to eq [one] }
        it { expect { decrypt(:one, vars) }.to raise_error OpenSSL::OpenSSLError }
      end

      describe 'private config on the same owner' do
        let(:travis_yml) { 'import: other/other:one.yml' }
        let(:private) { true }
        it { expect(vars).to eq [] }
      end
    end
  end

  describe 'importing a secret from a config, and from another config on the same repo' do
    let(:one_yml) do
      %(
        env:
          global:
            - secure: #{one}
        import: two.yml
      )
    end

    let(:two_yml) do
      %(
        env:
          global:
            - secure: #{two}
      )
    end

    describe 'from the same repo' do
      let(:private) { false }
      let(:travis_yml) { 'import: one.yml' }
      let(:one) { encrypt(:one, 'secret_one') }
      let(:two) { encrypt(:one, 'secret_two') }

      before { expect_any_instance_of(Travis::Yml::Configs::Model::Repo).to receive(:reencrypt).never }

      it { expect(vars).to eq [two, one] }
      it { expect(decrypt(:one, vars)).to eq %w(secret_two secret_one) }
    end

    describe 'frm the same owner' do
      let(:one) { encrypt(:two, 'secret_one') }
      let(:two) { encrypt(:two, 'secret_two') }

      describe 'public config' do
        let(:travis_yml) { 'import: travis-ci/other:one.yml' }
        let(:private) { false }
        it { expect(vars).to_not eq [one, two] }
        it { expect(decrypt(:one, vars)).to eq %w(secret_two secret_one) }
      end

      describe 'private config on the same owner' do
        let(:travis_yml) { 'import: travis-ci/other:one.yml' }
        let(:private) { true }
        it { expect(vars).to_not eq [one, two] }
        it { expect(decrypt(:one, vars)).to eq %w(secret_two secret_one) }
      end
    end

    describe 'from another owner' do
      let(:one) { encrypt(:two, 'secret_one') }
      let(:two) { encrypt(:two, 'secret_two') }

      describe 'public config' do
        let(:travis_yml) { 'import: other/other:one.yml' }
        let(:private) { false }
        it { expect(vars).to eq [two, one] }
        it { expect { decrypt(:one, vars) }.to raise_error OpenSSL::OpenSSLError }
      end

      describe 'private config on the same owner' do
        let(:travis_yml) { 'import: other/other:one.yml' }
        let(:private) { true }
        it { expect(vars).to eq [] }
      end
    end
  end

  describe 'importing config that imports a secret from another config on the same repo' do
    let(:one_yml) do
      %(
        import: two.yml
      )
    end

    let(:two_yml) do
      %(
        env:
          global:
            - secure: #{two}
      )
    end

    describe 'from the same repo' do
      let(:private) { false }
      let(:travis_yml) { 'import: one.yml' }
      let(:two) { encrypt(:one, 'secret_two') }

      before { expect_any_instance_of(Travis::Yml::Configs::Model::Repo).to receive(:reencrypt).never }

      it { expect(vars).to eq [two] }
      it { expect(decrypt(:one, vars)).to eq %w(secret_two) }
    end

    describe 'frm the same owner' do
      let(:two) { encrypt(:two, 'secret_two') }

      describe 'public config' do
        let(:travis_yml) { 'import: travis-ci/other:one.yml' }
        let(:private) { false }
        it { expect(vars).to_not eq [two] }
        it { expect(decrypt(:one, vars)).to eq %w(secret_two) }
      end

      describe 'private config on the same owner' do
        let(:travis_yml) { 'import: travis-ci/other:one.yml' }
        let(:private) { true }
        it { expect(vars).to_not eq [two] }
        it { expect(decrypt(:one, vars)).to eq %w(secret_two) }
      end
    end

    describe 'from another owner' do
      let(:one) { encrypt(:two, 'secret_one') }
      let(:two) { encrypt(:two, 'secret_two') }

      describe 'public config' do
        let(:travis_yml) { 'import: other/other:one.yml' }
        let(:private) { false }
        it { expect(vars).to eq [two] }
        it { expect { decrypt(:one, vars) }.to raise_error OpenSSL::OpenSSLError }
      end

      describe 'private config on the same owner' do
        let(:travis_yml) { 'import: other/other:one.yml' }
        let(:private) { true }
        it { expect(vars).to eq [] }
      end
    end
  end
end

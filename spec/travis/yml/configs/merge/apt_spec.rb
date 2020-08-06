describe Travis::Yml::Configs, 'merging apt' do
  let(:repo) { { id: 1, github_id: 1, slug: 'travis-ci/travis-yml', private: false, token: 'token', private_key: 'key', allow_config_imports: true } }

  before { stub_content(repo[:id], '.travis.yml', travis_yml) }
  before { stub_content(repo[:id], 'one.yml', one) }
  before { stub_content(repo[:id], 'two.yml', two) }

  subject { described_class.new(repo, 'master', api ? [config: api, mode: mode] : nil, {}, opts).tap(&:load) }

  let(:travis_yml) do
    %(
      import:
      - source: one.yml
        mode: #{mode}
      addons:
        apt:
          packages:
          - cmake
        chrome: stable
    )
  end

  let(:one) do
    %(
      import:
      - source: two.yml
        mode: #{mode}
      addons:
        apt:
          packages:
          - curl
        hostname: one
    )
  end

  let(:two) do
    %(
      addons:
        apt:
          packages:
          - wget
    )
  end

  describe 'merge_normalized turned off' do
    describe '.travis.yml' do
      let(:api) { nil }

      describe 'deep_merge_append' do
        let(:mode) { :deep_merge_append }
        it do
          should serialize_to(
            addons: { apt: { packages: ['wget', 'curl', 'cmake'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'deep_merge_prepend' do
        let(:mode) { :deep_merge_prepend }
        it do
          should serialize_to(
            addons: { apt: { packages: ['cmake', 'curl', 'wget'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'deep_merge' do
        let(:mode) { :deep_merge }
        it do
          should serialize_to(
            addons: { apt: { packages: ['cmake'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'merge' do
        let(:mode) { :merge }
        it do
          should serialize_to(
            addons: { apt: { packages: ['cmake'] }, chrome: 'stable' }
          )
        end
      end

      describe 'replace' do
        let(:mode) { :replace }
        it do
          should serialize_to(
            addons: { apt: { packages: ['cmake'] }, chrome: 'stable' }
          )
        end
      end
    end

    describe 'api' do
      let(:api) do
        %(
          addons:
            apt:
              packages:
              - vim
        )
      end

      describe 'deep_merge_append' do
        let(:mode) { :deep_merge_append }
        it do
          should serialize_to(
            addons: { apt: { packages: ['wget', 'curl', 'cmake', 'vim'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'deep_merge_prepend' do
        let(:mode) { :deep_merge_prepend }
        it do
          should serialize_to(
            addons: { apt: { packages: ['vim', 'cmake', 'curl', 'wget'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'deep_merge' do
        let(:mode) { :deep_merge }
        it do
          should serialize_to(
            addons: { apt: { packages: ['vim'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'merge' do
        let(:mode) { :merge }
        it do
          should serialize_to(
            addons: { apt: { packages: ['vim'] } }
          )
        end
      end

      describe 'replace' do
        let(:mode) { :replace }
        it do
          should serialize_to(
            addons: { apt: { packages: ['vim'] } }
          )
        end
      end
    end

    describe 'api (empty)' do
      let(:api) { '' }

      describe 'replace' do
        let(:mode) { :replace }
        it { should serialize_to empty }
      end
    end
  end

  describe 'merge_normalized turned on', merge_normalized: true do
    describe '.travis.yml' do
      let(:api) { nil }

      describe 'deep_merge_append' do
        let(:mode) { :deep_merge_append }
        it do
          should serialize_to(
            addons: { apt: { packages: ['wget', 'curl', 'cmake'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'deep_merge_prepend' do
        let(:mode) { :deep_merge_prepend }
        it do
          should serialize_to(
            addons: { apt: { packages: ['cmake', 'curl', 'wget'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'deep_merge' do
        let(:mode) { :deep_merge }
        it do
          should serialize_to(
            addons: { apt: { packages: ['cmake'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'merge' do
        let(:mode) { :merge }
        it do
          should serialize_to(
            addons: { apt: { packages: ['cmake'] }, chrome: 'stable' }
          )
        end
      end

      describe 'replace' do
        let(:mode) { :replace }
        it do
          should serialize_to(
            addons: { apt: { packages: ['cmake'] }, chrome: 'stable' }
          )
        end
      end
    end

    describe 'api' do
      let(:api) do
        %(
          addons:
            apt:
              packages:
              - vim
        )
      end

      describe 'deep_merge_append' do
        let(:mode) { :deep_merge_append }
        it do
          should serialize_to(
            addons: { apt: { packages: ['wget', 'curl', 'cmake', 'vim'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'deep_merge_prepend' do
        let(:mode) { :deep_merge_prepend }
        it do
          should serialize_to(
            addons: { apt: { packages: ['vim', 'cmake', 'curl', 'wget'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'deep_merge' do
        let(:mode) { :deep_merge }
        it do
          should serialize_to(
            addons: { apt: { packages: ['vim'] }, chrome: 'stable', hostname: 'one' }
          )
        end
      end

      describe 'merge' do
        let(:mode) { :merge }
        it do
          should serialize_to(
            addons: { apt: { packages: ['vim'] } }
          )
        end
      end

      describe 'replace' do
        let(:mode) { :replace }
        it do
          should serialize_to(
            addons: { apt: { packages: ['vim'] } }
          )
        end
      end
    end
  end
end

describe Travis::Yml::Configs, 'merging cache' do
  let(:repo) { { github_id: 1, slug: 'travis-ci/travis-yml', private: false, token: 'token', private_key: 'key', allow_config_imports: true } }

  before { stub_content(repo[:github_id], '.travis.yml', travis_yml) }
  before { stub_content(repo[:github_id], 'one.yml', one) }
  before { stub_content(repo[:github_id], 'two.yml', two) }

  subject { described_class.new(repo, 'master', api ? [config: api, mode: mode] : nil, {}, opts).tap(&:load) }

  let(:travis_yml) do
    %(
      import:
      - source: one.yml
        mode: #{mode}
      cache:
        apt: true
    )
  end

  let(:one) do
    %(
      import:
      - source: two.yml
        mode: #{mode}
      cache:
        bundler: true
    )
  end

  let(:two) do
    %(
      cache:
        directories: ./one
    )
  end

  describe 'merge_normalized turned off' do
    describe '.travis.yml' do
      let(:api) { nil }

      describe 'deep_merge_append' do
        let(:mode) { :deep_merge_append }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'] }
          )
        end
      end

      describe 'deep_merge_prepend' do
        let(:mode) { :deep_merge_prepend }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'] }
          )
        end
      end

      describe 'deep_merge' do
        let(:mode) { :deep_merge }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'] }
          )
        end
      end

      describe 'merge' do
        let(:mode) { :merge }
        it do
          should serialize_to(
            cache: { apt: true }
          )
        end
      end

      describe 'replace' do
        let(:mode) { :replace }
        it do
          should serialize_to(
            cache: { apt: true }
          )
        end
      end
    end

    describe 'api' do
      let(:api) do
        %(
          cache:
            timeout: 1
        )
      end

      describe 'deep_merge_append' do
        let(:mode) { :deep_merge_append }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'], timeout: 1 }
          )
        end
      end

      describe 'deep_merge_prepend' do
        let(:mode) { :deep_merge_prepend }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'], timeout: 1 }
          )
        end
      end

      describe 'deep_merge' do
        let(:mode) { :deep_merge }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'], timeout: 1 }
          )
        end
      end

      describe 'merge' do
        let(:mode) { :merge }
        it do
          should serialize_to(
            cache: { timeout: 1 }
          )
        end
      end

      describe 'replace' do
        let(:mode) { :replace }
        it do
          should serialize_to(
            cache: { timeout: 1 }
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
            cache: { apt: true, bundler: true, directories: ['./one'] }
          )
        end
      end

      describe 'deep_merge_prepend' do
        let(:mode) { :deep_merge_prepend }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'] }
          )
        end
      end

      describe 'deep_merge' do
        let(:mode) { :deep_merge }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'] }
          )
        end
      end

      describe 'merge' do
        let(:mode) { :merge }
        it do
          should serialize_to(
            cache: { apt: true }
          )
        end
      end

      describe 'replace' do
        let(:mode) { :replace }
        it do
          should serialize_to(
            cache: { apt: true }
          )
        end
      end
    end

    describe 'api' do
      let(:api) do
        %(
          cache:
            timeout: 1
        )
      end

      describe 'deep_merge_append' do
        let(:mode) { :deep_merge_append }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'], timeout: 1 }
          )
        end
      end

      describe 'deep_merge_prepend' do
        let(:mode) { :deep_merge_prepend }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'], timeout: 1 }
          )
        end
      end

      describe 'deep_merge' do
        let(:mode) { :deep_merge }
        it do
          should serialize_to(
            cache: { apt: true, bundler: true, directories: ['./one'], timeout: 1 }
          )
        end
      end

      describe 'merge' do
        let(:mode) { :merge }
        it do
          should serialize_to(
            cache: { timeout: 1 }
          )
        end
      end

      describe 'replace' do
        let(:mode) { :replace }
        it do
          should serialize_to(
            cache: { timeout: 1 }
          )
        end
      end
    end
  end
end

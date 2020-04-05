# describe Travis::Yml::Configs, 'merge tags' do
#   let(:repo) { { github_id: 1, slug: 'travis-ci/travis-yml', private: false, token: 'token', private_key: 'key', allow_config_imports: true } }
#   let(:api) { nil }
#
#   before { stub_content(repo[:github_id], '.travis.yml', travis_yml) }
#   before { stub_content(repo[:github_id], 'one.yml', one) }
#   before { stub_content(repo[:github_id], 'two.yml', two) }
#
#   subject { described_class.new(repo, 'master', api ? [config: api, mode: mode] : nil, {}, opts).tap(&:load) }
#
#   describe 'on root' do
#     let(:travis_yml) do
#       %(
#         #{tag}
#         import: one.yml
#         addons:
#           apt:
#             packages:
#             - one
#           chrome: stable
#         cache:
#           apt: true
#         env:
#           jobs:
#           - TRAVIS=true
#         script:
#           - ./travis
#       )
#     end
#
#     let(:one) do
#       %(
#         #{tag}
#         os: linux
#         import: two.yml
#         addons:
#           apt:
#             packages:
#             - two
#           hostname: one
#         cache:
#           bundler: true
#         env:
#           jobs:
#           - ONE=true
#         script:
#         - ./one
#       )
#     end
#
#     let(:two) do
#       %(
#         addons:
#           apt:
#             packages:
#             - three
#         cache:
#           directories: ./one
#         script:
#         - ./two
#       )
#     end
#
#     describe '!deep_merge+append' do
#       let(:tag) { '!deep_merge+append' }
#
#       it do
#         should serialize_to(
#           os: ['linux'],
#           addons: { apt: { packages: %w(three two one) }, chrome: 'stable', hostname: 'one' },
#           cache: { apt: true, bundler: true, directories: ['./one'] },
#           env: { jobs: [{ ONE: 'true' }, { TRAVIS: 'true' }] },
#           script: %w(./two ./one ./travis),
#         )
#       end
#     end
#
#     describe '!deep_merge+prepend' do
#       let(:tag) { '!deep_merge+prepend' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one two three) }, chrome: 'stable', hostname: 'one' },
#           cache: { apt: true, bundler: true, directories: ['./one'] },
#           env: { jobs: [{ TRAVIS: 'true' }, { ONE: 'true' }] },
#           script: %w( ./travis ./one ./two),
#           os: ['linux'],
#         )
#       end
#     end
#
#     describe '!deep_merge' do
#       let(:tag) { '!deep_merge' }
#
#       it do
#         should serialize_to(
#           os: ['linux'],
#           addons: { apt: { packages: %w(one) }, chrome: 'stable', hostname: 'one' },
#           cache: { apt: true, bundler: true, directories: ['./one'] },
#           env: { jobs: [{ TRAVIS: 'true' }] },
#           script: %w( ./travis),
#         )
#       end
#     end
#
#     describe '!merge' do
#       let(:tag) { '!merge' }
#
#       it do
#         should serialize_to(
#           os: ['linux'],
#           addons: { apt: { packages: %w(one) }, chrome: 'stable' },
#           cache: { apt: true },
#           env: { jobs: [{ TRAVIS: 'true' }] },
#           script: %w( ./travis),
#         )
#       end
#     end
#
#     describe '!replace' do
#       let(:tag) { '!replace' }
#
#       it do
#         should serialize_to(
#           cache: { apt: true },
#           addons: { apt: { packages: %w(one) }, chrome: 'stable' },
#           env: { jobs: [{ TRAVIS: 'true' }] },
#           script: %w( ./travis),
#         )
#       end
#     end
#   end
#
#   describe 'on addons' do
#     let(:travis_yml) do
#       %(
#         import: one.yml
#         addons: #{tag}
#           apt:
#             packages:
#             - one
#           chrome: stable
#       )
#     end
#
#     let(:one) do
#       %(
#         import: two.yml
#         addons: #{tag}
#           apt:
#             packages:
#             - two
#           hostname: one
#       )
#     end
#
#     let(:two) do
#       %(
#         addons:
#           apt:
#             packages:
#             - three
#       )
#     end
#
#     describe '!deep_merge+append' do
#       let(:tag) { '!deep_merge+append' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(three two one) }, chrome: 'stable', hostname: 'one' },
#         )
#       end
#     end
#
#     describe '!deep_merge+prepend' do
#       let(:tag) { '!deep_merge+prepend' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one two three) }, chrome: 'stable', hostname: 'one' },
#         )
#       end
#     end
#
#     describe '!deep_merge' do
#       let(:tag) { '!deep_merge' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one) }, chrome: 'stable', hostname: 'one' },
#         )
#       end
#     end
#
#     describe '!merge' do
#       let(:tag) { '!merge' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one) }, chrome: 'stable', hostname: 'one' },
#         )
#       end
#     end
#
#     describe '!replace' do
#       let(:tag) { '!replace' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one) }, chrome: 'stable' },
#         )
#       end
#     end
#   end
#
#   describe 'on addons.apt' do
#     let(:travis_yml) do
#       %(
#         import: one.yml
#         addons:
#           apt: #{tag}
#             packages:
#             - one
#       )
#     end
#
#     let(:one) do
#       %(
#         import: two.yml
#         addons:
#           apt: #{tag}
#             packages:
#             - two
#       )
#     end
#
#     let(:two) do
#       %(
#         addons:
#           apt:
#             packages:
#             - three
#       )
#     end
#
#     describe '!deep_merge+append' do
#       let(:tag) { '!deep_merge+append' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(three two one) } },
#         )
#       end
#     end
#
#     describe '!deep_merge+prepend' do
#       let(:tag) { '!deep_merge+prepend' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one two three) } },
#         )
#       end
#     end
#
#     describe '!deep_merge' do
#       let(:tag) { '!deep_merge' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one) } },
#         )
#       end
#     end
#
#     describe '!merge' do
#       let(:tag) { '!merge' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one) } },
#         )
#       end
#     end
#
#     describe '!replace' do
#       let(:tag) { '!replace' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one) } },
#         )
#       end
#     end
#   end
#
#   describe 'on addons.apt.packages' do
#     let(:travis_yml) do
#       %(
#         import: one.yml
#         addons:
#           apt:
#             packages: #{tag}
#             - one
#       )
#     end
#
#     let(:one) do
#       %(
#         import: two.yml
#         addons:
#           apt:
#             packages: #{tag}
#             - two
#       )
#     end
#
#     let(:two) do
#       %(
#         addons:
#           apt:
#             packages:
#             - three
#       )
#     end
#
#     describe '!append' do
#       let(:tag) { '!append' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(three two one) } },
#         )
#       end
#     end
#
#     describe '!prepend' do
#       let(:tag) { '!prepend' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one two three) } },
#         )
#       end
#     end
#
#     describe '!replace' do
#       let(:tag) { '!replace' }
#
#       it do
#         should serialize_to(
#           addons: { apt: { packages: %w(one) } },
#         )
#       end
#     end
#   end
# end

# describe Travis::Yml::Schema, 'accept deploy', slow: true do
#   subject { described_class.schema }
#
#   xit { puts JSON.pretty_generate(subject[:definitions][:launchpad]) }
#
#   describe 'launchpad' do
#     describe 'slug' do
#       it { should validate deploy: { provider: :launchpad, slug: 'str' } }
#       it { should_not validate deploy: { provider: :launchpad, slug: 1 } }
#       it { should_not validate deploy: { provider: :launchpad, slug: true } }
#       it { should_not validate deploy: { provider: :launchpad, slug: ['str'] } }
#       it { should_not validate deploy: { provider: :launchpad, slug: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :launchpad, slug: [{:foo=>'foo'}] } }
#     end
#
#     describe 'oauth_token' do
#       it { should validate deploy: { provider: :launchpad, oauth_token: 'str' } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token: 1 } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token: true } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token: ['str'] } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token: [{:foo=>'foo'}] } }
#     end
#
#     describe 'oauth_token_secret' do
#       it { should validate deploy: { provider: :launchpad, oauth_token_secret: 'str' } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token_secret: 1 } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token_secret: true } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token_secret: ['str'] } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token_secret: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :launchpad, oauth_token_secret: [{:foo=>'foo'}] } }
#     end
#   end
# end

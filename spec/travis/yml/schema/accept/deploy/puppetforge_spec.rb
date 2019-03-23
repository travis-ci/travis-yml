# describe Travis::Yml::Schema, 'accept deploy', slow: true do
#   subject { described_class.schema }
#
#   it { puts JSON.pretty_generate(subject[:definitions][:puppetforge]) }
#
#   describe 'puppetforge' do
#     describe 'user' do
#       it { should validate deploy: { provider: :puppetforge, user: 'str' } }
#       it { should_not validate deploy: { provider: :puppetforge, user: 1 } }
#       it { should_not validate deploy: { provider: :puppetforge, user: true } }
#       it { should_not validate deploy: { provider: :puppetforge, user: ['str'] } }
#       it { should_not validate deploy: { provider: :puppetforge, user: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :puppetforge, user: [{:foo=>'foo'}] } }
#     end
#
#     describe 'password' do
#       it { should validate deploy: { provider: :puppetforge, password: 'str' } }
#       it { should_not validate deploy: { provider: :puppetforge, password: 1 } }
#       it { should_not validate deploy: { provider: :puppetforge, password: true } }
#       it { should_not validate deploy: { provider: :puppetforge, password: ['str'] } }
#       it { should_not validate deploy: { provider: :puppetforge, password: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :puppetforge, password: [{:foo=>'foo'}] } }
#     end
#
#     describe 'url' do
#       it { should validate deploy: { provider: :puppetforge, url: 'str' } }
#       it { should_not validate deploy: { provider: :puppetforge, url: 1 } }
#       it { should_not validate deploy: { provider: :puppetforge, url: true } }
#       it { should_not validate deploy: { provider: :puppetforge, url: ['str'] } }
#       it { should_not validate deploy: { provider: :puppetforge, url: {:foo=>'foo'} } }
#       it { should_not validate deploy: { provider: :puppetforge, url: [{:foo=>'foo'}] } }
#     end
#   end
# end

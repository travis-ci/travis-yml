# describe Travis::Yml::Schema::Dsl::Str do
#   let(:dsl) { Class.new(described_class).new }
#
#   subject { dsl.node}
#
#   describe 'strict' do
#     describe 'given true' do
#       before { dsl.strict true }
#       it { should be_strict }
#       it { should have_opts strict: true }
#     end
#
#     describe 'given false' do
#       before { dsl.strict false }
#       it { should_not be_strict }
#       it { should have_opts strict: false }
#     end
#   end
#
#   describe 'values' do
#     describe 'given a number of strs' do
#       before { dsl.values 'one', 'two' }
#       it { should have_opts enum: ['one', 'two'] }
#     end
#
#     describe 'given a seq of strs' do
#       before { dsl.values ['one', 'two'] }
#       it { should have_opts enum: ['one', 'two'] }
#     end
#
#     describe 'given a map' do
#       before { dsl.values value: 'one' }
#       it { should have_opts enum: ['one'] }
#     end
#
#     describe 'given a seq of maps' do
#       before { dsl.values [value: 'one'] }
#       it { should have_opts enum: ['one'] }
#     end
#
#     describe 'given a str and a map with only' do
#       before { dsl.values 'one', only: { os: 'linux' } }
#       it { should have_opts enum: ['one'], values: { one: { only: { os: ['linux'] } } } }
#     end
#
#     describe 'given str and a a map with except' do
#       before { dsl.values 'one', except: { os: 'linux' } }
#       it { should have_opts enum: ['one'], values: { one: { except: { os: ['linux'] } } } }
#     end
#
#     describe 'given a str and a map with deprecated' do
#       before { dsl.values value: 'one', deprecated: true }
#       it { should have_opts enum: ['one'], values: { one: { deprecated: true } } }
#     end
#
#     describe 'given a map with only' do
#       before { dsl.values value: 'one', only: { os: 'linux' } }
#       it { should have_opts enum: ['one'], values: { one: { only: { os: ['linux'] } } } }
#     end
#
#     describe 'given a map with except' do
#       before { dsl.values value: 'one', except: { os: 'linux' } }
#       it { should have_opts enum: ['one'], values: { one: { except: { os: ['linux'] } } } }
#     end
#
#     describe 'given a map with deprecated' do
#       before { dsl.values [value: 'one', deprecated: true] }
#       it { should have_opts enum: ['one'], values: { one: { deprecated: true } } }
#     end
#
#     describe 'given a map with deprecated' do
#       before { dsl.values [value: 'one', deprecated: true] }
#       it { should have_opts enum: ['one'], values: { one: { deprecated: true } } }
#     end
#
#     describe 'given a map with only' do
#       before { dsl.values [value: 'one', only: { os: 'linux' }] }
#       it { should have_opts enum: ['one'], values: { one: { only: { os: ['linux'] } } } }
#     end
#
#     describe 'given a map with except' do
#       before { dsl.values [value: 'one', except: { os: 'linux' }] }
#       it { should have_opts enum: ['one'], values: { one: { except: { os: ['linux'] } } } }
#     end
#
#     describe 'given a map with deprecated' do
#       before { dsl.values [value: 'one', deprecated: true] }
#       it { should have_opts enum: ['one'], values: { one: { deprecated: true } } }
#     end
#   end
# end

# describe Travis::Yml::Doc::Schema::Enum do
#   let(:enum) { described_class.new(schema) }
#
#   let(:schema) do
#     {
#       type: :string,
#       enum: ['one', 'two'],
#       values: [
#         value: 'one',
#         aliases: ['alias']
#       ],
#       strict: true
#     }
#   end
#
#   describe 'matches?' do
#     subject { enum.matches?(build_value(value)) }
#
#     describe 'given a known str' do
#       let(:value) { 'one' }
#       it { should be true }
#     end
#
#     describe 'given an alias' do
#       let(:value) { 'alias' }
#       it { should be true }
#     end
#
#     describe 'given an unknown str' do
#       describe 'on a strict enum' do
#         let(:value) { 'unknown' }
#         it { should be false }
#       end
#
#       describe 'on an unstrict enum' do
#         let(:value) { 'unknown' }
#         before { schema[:strict] = false }
#         it { should be true }
#       end
#     end
#
#     describe 'given a num' do
#       let(:value) { 1 }
#       it { should be false }
#     end
#
#     describe 'given a bool' do
#       let(:value) { true }
#       it { should be false }
#     end
#
#     describe 'given a none' do
#       let(:value) { nil }
#       it { should be false }
#     end
#
#     describe 'given a seq' do
#       let(:value) { ['str'] }
#       it { should be false }
#     end
#
#     describe 'given a map' do
#       let(:value) { { foo: 'foo' } }
#       it { should be false }
#     end
#   end
# end

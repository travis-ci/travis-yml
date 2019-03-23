# defaults can only be filled in if required keys are present, so it's pretty
# useless to unit test this class like this. does that mean the two classes
# Default and Required should be merged?
#
# describe Travis::Yml::Doc::Validate, 'default' do
#   subject { described_class.apply(build_schema(schema), build_value(value, required: true, defaults: true)) }
#
#   describe 'str' do
#     let(:schema) { { type: :string, defaults: [value: 'foo'] } }
#
#     describe 'given a str' do
#       let(:value) { 'foo' }
#       it { should_not have_msg }
#       it { should serialize_to value }
#     end
#
#     describe 'given an empty str' do
#       let(:value) { '' }
#       it { should have_msg [:info, :root, :default, default: 'foo']}
#       it { should serialize_to 'foo' }
#     end
#
#     describe 'given nil' do
#       let(:value) { nil }
#       it { should have_msg [:info, :root, :default, default: 'foo']}
#       it { should serialize_to 'foo' }
#     end
#   end
#
#   describe 'seq' do
#     let(:schema) { { type: :array, items: { type: :string, defaults: [value: 'foo'] } } }
#
#     describe 'given an array with a str' do
#       let(:value) { ['foo'] }
#       it { should_not have_msg }
#       it { should serialize_to value }
#     end
#
#     describe 'given an empty array' do
#       let(:value) { [] }
#       it { should have_msg [:info, :root, :default, default: 'foo']}
#       it { should serialize_to ['foo'] }
#     end
#
#     describe 'given nil' do
#       let(:value) { nil }
#       it { should have_msg [:info, :root, :default, default: 'foo']}
#       it { should serialize_to ['foo'] }
#     end
#   end
# end

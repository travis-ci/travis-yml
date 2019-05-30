# describe Travis::Yml::Schema::Dsl::Scalar do
#   let(:dsl)  { Class.new(described_class).new }
#
#   subject { dsl.node}
#
#   describe 'defaults' do
#     before { dsl.default 'str' }
#     it { should have_opts defaults: [{ value: 'str' }] }
#   end
#
#   describe 'default with support' do
#     before { dsl.default 'str', only: { os: 'linux' } }
#     it { should have_opts defaults: [{ value: 'str', only: { os: ['linux'] } }] }
#   end
# end

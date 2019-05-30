# describe Travis::Yml::Schema::Dsl::Node do
#   let(:dsl) { Class.new(described_class).new }
#
#   subject { dsl.node}
#
#   describe 'changes' do
#     describe 'given a strs' do
#       before { dsl.change :one, :two }
#       it { should have_opts changes: [{ change: :one }, { change: :two }] }
#     end
#
#     describe 'given a str and opts' do
#       before { dsl.change :one, foo: :bar }
#       it { should have_opts changes: [{ change: :one, foo: :bar }] }
#     end
#   end
#
#   describe 'export' do
#     before { dsl.export }
#     it { should be_export }
#   end
#
#   describe 'edge' do
#     before { dsl.edge }
#     it { should have_opts flags: [:edge] }
#   end
#
#   describe 'internal' do
#     before { dsl.internal }
#     it { should have_opts flags: [:internal] }
#   end
#
#   describe 'normal' do
#     before { dsl.normal }
#     it { should have_opts normal: true }
#   end
#
#   describe 'required' do
#     before { dsl.required }
#     it { should be_required }
#     it { should_not have_opts }
#   end
#
#   describe 'unique' do
#     before { dsl.unique }
#     it { should be_unique }
#     it { should have_opts unique: true }
#   end
#
#   describe 'only' do
#     before { dsl.supports :only, os: 'linux' }
#     it { expect(dsl.node.opts).to eq only: { os: ['linux'] } }
#   end
# end

# describe Travis::Yml::Schema::Dsl::Map, 'mapping a scalar' do
#   let(:dsl) { const(&define).new }
#   let(:map) { dsl.node }
#   let(:foo) { map[:foo] }
#
#   def const(&define)
#     Class.new(described_class) { define_method(:define, &define) }
#   end
#
#   describe 'default' do
#     let(:define) { -> { map :foo, to: :str, default: :str } }
#     it { expect(foo).to have_opts defaults: [{ value: 'str' }] }
#     it { expect(map).to_not have_opts }
#   end
#
#   describe 'default with only' do
#     let(:define) { -> { map :foo, to: :str, default: { value: :str, only: { os: 'linux' } } } }
#     it { expect(foo).to have_opts defaults: [{ value: 'str', only: { os: ['linux'] } }] }
#     it { expect(map).to_not have_opts }
#   end
# end

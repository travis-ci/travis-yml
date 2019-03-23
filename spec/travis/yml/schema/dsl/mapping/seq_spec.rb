describe Travis::Yml::Schema::Dsl::Map, 'mapping a seq' do
  let(:dsl) { const(&define).new }
  let(:map) { dsl.node }
  let(:foo) { map[:foo] }

  def const(&define)
    Class.new(described_class) { define_method(:define, &define) }
  end

  describe 'type' do
    let(:define) { -> { map :foo, to: :seq, type: :num } }
    it { expect(foo.schemas.first).to be_num }
  end
end

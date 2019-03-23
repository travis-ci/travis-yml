describe Travis::Yml::Schema::Dsl::Map, 'mapping a enum' do
  let(:dsl) { const(&define).new }
  let(:map) { dsl.node }
  let(:foo) { map[:foo] }

  def const(&define)
    Class.new(described_class) { define_method(:define, &define) }
  end

  describe 'strict' do
    describe 'given true' do
      let(:define) { -> { map :foo, to: :enum, strict: true } }
      it { expect(foo).to have_opts strict: true }
      it { expect(map).to_not have_opts }
    end

    describe 'given false' do
      let(:define) { -> { map :foo, to: :enum, strict: false } }
      it { expect(foo).to have_opts strict: false }
      it { expect(map).to_not have_opts }
    end
  end
end

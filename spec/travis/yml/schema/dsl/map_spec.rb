describe Travis::Yml::Schema::Dsl::Map do
  let(:dsl) { const(&define).new }
  let(:map) { dsl.node }
  let(:foo) { map[:foo] }

  def const(&define)
    Class.new(described_class) { define_method(:define, &define) }
  end

  describe 'edge' do
    let(:define) { -> { edge } }
    it { expect(map).to have_opts flags: [:edge] }
  end

  describe 'max_size' do
    let(:define) { -> { max_size 1 } }
    it { expect(map).to have_opts max_size: 1 }
  end

  describe 'prefix' do
    let(:define) { -> { prefix :foo } }
    it { expect(map).to have_opts prefix: :foo }
  end

  describe 'strict' do
    describe 'no mappings' do
      let(:define) { -> {} }
      it { expect(map).to_not be_strict }
      it { expect(map).to_not have_opts }
    end

    describe 'given mappings' do
      let(:define) { -> { map :foo, to: :str } }
      it { expect(map).to be_strict }
      it { expect(map).to_not have_opts }
    end

    describe 'given false' do
      let(:define) { -> { strict false } }
      it { expect(map).to_not be_strict }
      it { expect(map).to_not have_opts }
    end
  end
end

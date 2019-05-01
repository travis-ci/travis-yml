describe Travis::Yml::Schema::Dsl::Map, 'mapping a node' do
  let(:dsl) { const(&define).new }
  let(:map) { dsl.node }
  let(:foo) { map[:foo] }

  def const(&define)
    Class.new(described_class) { define_method(:define, &define) }
  end

  describe 'changes' do
    describe 'given a number of changes' do
      let(:define) { -> { map :foo, to: :str, change: [:foo, :bar] } }
      it { expect(foo).to have_opts changes: [{ change: :foo }, { change: :bar }] }
      it { expect(map).to_not have_opts }
    end

    describe 'given a change with opts' do
      let(:define) { -> { map :foo, to: :str, change: { change: :one, foo: :bar } } }
      it { expect(foo).to have_opts changes: [{ change: :one, foo: :bar }] }
      it { expect(map).to_not have_opts }
    end
  end

  describe 'edge' do
    let(:define) { -> { map :foo, to: :str, edge: true } }
    it { expect(foo).to have_opts flags: [:edge] }
    it { expect(map).to_not have_opts }
  end

  describe 'internal' do
    let(:define) { -> { map :foo, to: :str, internal: true } }
    it { expect(foo).to have_opts flags: [:internal] }
    it { expect(map).to_not have_opts }
  end

  describe 'normal' do
    let(:define) { -> { map :foo, to: :str, normal: true } }
    it { expect(foo).to have_opts normal: true }
    it { expect(map).to_not have_opts }
  end

  describe 'required' do
    let(:define) { -> { map :foo, to: :str, required: true } }
    it { expect(foo).to_not have_opts }
    it { expect(map).to have_opts required: [:foo] }
  end

  describe 'unique' do
    let(:define) { -> { map :foo, to: :str, unique: true } }
    it { expect(foo).to have_opts unique: true }
  end

  describe 'only' do
    let(:define) { -> { map :foo, to: :str, only: { os: 'linux' } } }
    it { expect(foo).to have_opts only: { os: ['linux'] } }
  end

  describe 'except' do
    let(:define) { -> { map :foo, to: :str, except: { os: 'linux' } } }
    it { expect(foo).to have_opts except: { os: ['linux'] } }
  end
end

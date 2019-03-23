describe Travis::Yaml::Doc::Value::Map do
  let(:value) { { env: { foo: 'foo' } } }
  let(:root)  { Travis::Yaml.build(value) }
  let(:env)   { root[:env] }

  describe 'set' do
    describe 'a node not having a parent' do
      let(:other) { build(nil, nil, 'bar') }

      before { env.set(:bar, other) }

      it { expect(env[:bar].parent).to eq env }
      it { expect(env[:bar].key).to eq :bar }
      it { expect(env.raw).to eq foo: 'foo', bar: 'bar' }
    end

    describe 'a node having a parent' do
      let(:parent) { build(nil, nil, {}) }
      let(:other)  { build(nil, nil, 'bar') }

      before { parent.set(:baz, other) }
      before { env.set(:bar, other) }

      it { expect(env[:bar].parent).to eq env }
      it { expect(env[:bar].key).to eq :bar }
      it { expect(env.raw).to eq foo: 'foo', bar: 'bar' }
    end
  end

  describe 'move' do
    before { env.move(:foo, :bar) }
    it { expect(env[:bar].parent).to eq env }
    it { expect(env[:bar].key).to eq :bar }
    it { expect(env.raw).to eq bar: 'foo' }
  end

  describe 'prepend' do
    let(:parent) { build(nil, nil, {}) }
    let(:other)  { build(nil, nil, { bar: 'bar' }) }

    before { parent.set(:other, other) }
    before { env.prepend(other) }

    it { expect(env[:bar].parent).to eq env }
    it { expect(env[:bar].key).to eq :bar }
    it { expect(env.keys).to eq [:bar, :foo] }
    it { expect(env.raw).to eq bar: 'bar', foo: 'foo' }
  end

  describe 'merge' do
    let(:other) { build(nil, nil, { bar: 'bar' }) }
    before { env.merge(other) }

    it { expect(env[:bar].parent).to eq env }
    it { expect(env[:bar].key).to eq :bar }
    it { expect(env.keys).to eq [:foo, :bar] }
    it { expect(env.raw).to eq foo: 'foo', bar: 'bar' }
  end

  describe 'raw' do
    let(:value) { { env: { foo: 'foo', bar: nil, baz: [] } } }
    it { expect(root.raw).to eq value }
  end

  describe 'serialize' do
    let(:value) { { env: { foo: 'foo', bar: nil, baz: [] } } }
    it { expect(root.serialize).to eq env: { foo: 'foo' } }
  end
end

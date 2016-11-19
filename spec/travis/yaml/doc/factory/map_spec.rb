describe Travis::Yaml::Doc::Factory::Map do
  let(:msgs)  { node.msgs }
  let(:node)  { Travis::Yaml::Doc::Type::Map.new(nil, :key, {}, {}) }
  let(:spec)  { { type: :map, map: map } }
  let(:map)   { {} }
  let(:value) { { foo: 'foo' } }
  let(:child) { node.children.first }

  before { described_class.new(spec, value, node).map_children }

  describe 'given a required key' do
    let(:value) { {} }
    let(:map)   { { lang: { key: :lang, types: [{ type: :scalar, required: true }] } } }

    it { expect(node.children.size).to eq 1 }
    it { expect(child).to be_a Travis::Yaml::Doc::Type::Scalar }
    it { expect(child.key).to eq :lang }
    it { expect(child.value).to be nil }
    it { expect(child).to_not be_given }
    it { expect(child).to be_known }
  end

  describe 'given a mapped key' do
    let(:value) { { foo: 'foo' } }
    let(:map)   { { foo: { key: :foo, types: [] } } }

    it { expect(node.children.size).to eq 1 }
    it { expect(child).to be_a Travis::Yaml::Doc::Type::Scalar }
    it { expect(child.key).to eq :foo }
    it { expect(child.value).to eq 'foo' }
    it { expect(child).to be_given }
    it { expect(child).to be_known }
  end

  describe 'given a mapped, aliased key' do
    let(:value) { { bar: 'foo' } }
    let(:map)   { { foo: { key: :foo, types: [{ type: :scalar, alias: ['bar'] }] } } }

    it { expect(node.children.size).to eq 1 }
    it { expect(child).to be_a Travis::Yaml::Doc::Type::Scalar }
    it { expect(child.key).to eq :foo }
    it { expect(child.value).to eq 'foo' }
    it { expect(child).to be_given }
    it { expect(child).to be_known }
    it { expect(msgs).to include [:info, :key, :alias, '"bar" is an alias for "foo", using "foo"'] }
  end

  describe 'given an unmapped key (scalar)' do
    let(:value) { { foo: 'foo' } }

    it { expect(node.children.size).to eq 1 }
    it { expect(child).to be_a Travis::Yaml::Doc::Type::Scalar }
    it { expect(child.key).to eq :foo }
    it { expect(child.value).to eq 'foo' }
    it { expect(child).to be_given }
    it { expect(child).to_not be_known }
  end

  describe 'given an unmapped key (map)' do
    let(:value) { { foo: { bar: 'bar' } } }

    it { expect(node.children.size).to eq 1 }
    it { expect(child).to be_a Travis::Yaml::Doc::Type::Map }
    it { expect(child.key).to eq :foo }
    it { expect(child.value).to eq bar: 'bar' }
    it { expect(child).to be_given }
    it { expect(child).to_not be_known }
    it { expect(child).to_not be_strict }
  end

  describe 'inherits opts from the type spec' do
    let(:value) { { foo: { bar: 'bar' } } }
    let(:spec)  { { type: :map, required: true, map: map } }
    it { expect(child).to be_required }
  end

  describe 'inherits opts from the mapping spec' do
    let(:value) { { foo: { bar: 'bar' } } }
    let(:map)   { { foo: { key: :foo, required: true, types: [] } } }
    it { expect(child).to be_required }
  end
end

describe Travis::Yaml::Doc::Factory::Seq do
  let(:node)  { Travis::Yaml::Doc::Type::Seq.new(nil, :key, [], {}) }
  let(:spec)  { { type: :seq } }
  let(:value) { ['foo'] }
  let(:child) { node.children.first }

  before { described_class.new(spec, value, node).add_children }

  describe 'given a string' do
    let(:value) { 'foo' }
    it { expect(child).to be_a(Travis::Yaml::Doc::Type::Scalar) }
    it { expect(child.value).to eq 'foo' }
  end

  describe 'given an array' do
    it { expect(child).to be_a(Travis::Yaml::Doc::Type::Scalar) }
    it { expect(child.value).to eq 'foo' }
  end

  describe 'detects a type matching the value' do
    let(:spec) { { type: :seq, types: [name: :foo, type: :scalar] } }
    it { expect(child).to be_a(Travis::Yaml::Doc::Type::Scalar) }
    it { expect(child.value).to eq 'foo' }
  end

  describe 'adds types to the node opts' do
    let(:spec) { { types: [name: :foo, type: :scalar] } }
    it { expect(node.opts[:types]).to eq spec[:types] }
  end

  describe 'inherits opts to the child' do
    let(:spec) { { known: true } }
    it { expect(child).to be_known }
  end

  describe 'sets the child to :given' do
    it { expect(child).to be_given }
  end
end

describe Travis::Yaml::Doc::Factory::Types do
  let(:types) do
    [
      { name: :foo, type: :map },
      { name: :bar, type: :seq },
      { name: :baz, type: :scalar }
    ]
  end

  subject { described_class.new(types, value).detect }

  describe 'finds a type matching a hash' do
    let(:value) { { foo: 'foo' } }
    it { should eq name: :foo, type: :map }
  end

  describe 'finds a type matching an array' do
    let(:value) { ['foo'] }
    it { should eq name: :bar, type: :seq }
  end

  describe 'finds a type matching a scalar' do
    let(:value) { 'foo' }
    it { should eq name: :baz, type: :scalar }
  end

  describe 'does a lookup' do
    let(:types) { [{ type: :lookup, keys: [:provider] }, { name: :heroku, type: :map }] }
    let(:value) { { provider: :heroku } }
    it { should eq name: :heroku, type: :map }
  end

  describe 'picks the first type otherwise' do
    let(:types) { [type: :wat] }
    let(:value) { true }
    it { should eq type: :wat }
  end

  describe 'defaults to an open :map for a hash' do
    let(:types) { [] }
    let(:value) { {} }
    it { should eq type: :map, strict: false }
  end

  describe 'defaults to a :seq for an array' do
    let(:types) { [] }
    let(:value) { [] }
    it { should eq type: :seq }
  end

  describe 'defaults to a :scalar for an string' do
    let(:types) { [] }
    let(:value) { 'foo' }
    it { should eq type: :scalar }
  end
end

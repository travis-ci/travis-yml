describe Travis::Yml::Schema::Json::Map, 'mapping to any node' do
  let(:map) { Travis::Yml::Schema::Dsl::Map.new }

  subject { described_class.new(map).node.schema }

  it { should eq type: :object }

  describe 'alias' do
    before { map.map :foo, to: :str, alias: :bar }
    it { should include properties: { foo: hash_including(aliases: anything) } }
    it { should_not include alias: anything }
    it { should_not include properties: { foo: hash_including(alias: anything) } }
  end

  describe 'change' do
    before { map.map :foo, to: :str, change: :change }
    it { should_not include changes: anything }
    it { should include properties: { foo: hash_including(changes: [change: :change]) } }
  end

  describe 'deprecated' do
    before { map.map :foo, to: :str, deprecated: true }
    it { should_not include deprecated: anything }
    it { should include properties: { foo: hash_including(deprecated: true) } }
  end

  describe 'edge' do
    before { map.map :foo, to: :str, edge: true }
    it { should_not include flags: anything }
    it { should include properties: { foo: hash_including(flags: [:edge]) } }
  end

  describe 'internal' do
    before { map.map :foo, to: :str, internal: true }
    it { should_not include flags: anything }
    it { should include properties: { foo: hash_including(flags: [:internal]) } }
  end

  # describe 'expand' do
  #   before { map.map :foo, to: :str, expand: true }
  #   it { should_not include expand: anything }
  #   it { should_not include properties: { foo: hash_including(expand: anything) } }
  # end

  describe 'required' do
    before { map.map :foo, to: :str, required: true }
    it { should include required: [:foo] }
    it { should_not include properties: { foo: hash_including(required: anything) } }
  end

  describe 'unique' do
    before { map.map :foo, to: :str, unique: true }
    it { should include properties: { foo: hash_including(unique: anything) } }
  end

  describe 'only' do
    before { map.map :foo, to: :str, only: { os: 'linux' } }
    it { should include properties: { foo: hash_including(only: anything) } }
  end

  describe 'except' do
    before { map.map :foo, to: :str, except: { os: 'linux' } }
    it { should include properties: { foo: hash_including(except: anything) } }
  end
end

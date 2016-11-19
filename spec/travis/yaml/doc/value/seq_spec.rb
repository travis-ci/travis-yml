describe Travis::Yaml::Doc::Value::Seq do
  let(:value) { { os: ['osx'] } }
  let(:root)  { Travis::Yaml.build(value) }
  let(:oss)   { root[:os] }
  let(:os)    { oss.first }

  describe 'key=' do
    before { oss.key = :foo }
    it { expect(oss.key).to eq :foo }
    it { expect(os.key).to  eq :foo }
  end

  describe 'map' do
    let(:other) { oss.map { |node| node.value.upcase! } }
    it { expect(other.parent).to eq root }
    it { expect(other.first.parent).to eq other }
    it { expect(other.raw).to eq ['OSX'] }
  end

  describe 'select' do
    let(:other) { oss.select { |node| node.present? } }
    it { expect(other.parent).to eq root }
    it { expect(other.first.parent).to eq other }
    it { expect(other.raw).to eq ['osx'] }
  end

  describe 'inject' do
    let(:other) { oss.inject([]) { |other, node| other.push(node) } }
    it { expect(other.parent).to eq root }
    it { expect(other.first.parent).to eq other }
    it { expect(other.raw).to eq ['osx'] }
  end

  describe 'push' do
    before { oss.push(Travis::Yaml::Doc::Value.build(nil, nil, 'linux', nil)) }
    it { expect(oss[1].key).to eq :os }
    it { expect(oss[1].parent).to eq oss }
    it { expect(oss.raw).to eq ['osx', 'linux'] }
  end

  describe 'replace' do
    describe 'given a single node' do
      let(:other) { Travis::Yaml::Doc::Value.build(nil, nil, ['linux'], nil) }
      before { oss.replace(other) }
      it { expect(oss[0].key).to eq :os }
      it { expect(oss[0].parent).to eq oss }
      it { expect(oss.raw).to eq ['linux'] }
    end

    describe 'given several nodes' do
      let(:other) { Travis::Yaml::Doc::Value.build(nil, nil, 'linux', nil) }
      before { oss.replace(oss[0], other) }
      it { expect(oss[0].key).to eq :os }
      it { expect(oss[0].parent).to eq oss }
      it { expect(oss.raw).to eq ['linux'] }
    end
  end

  describe 'merge' do
    let(:value) { { env: [{ foo: 'foo' }, { bar: 'bar' }] } }
    let(:other) { root[:env].merge }
    it { expect(other.key).to eq :env }
    it { expect(other.parent).to eq root }
    it { expect(other.raw).to eq foo: 'foo', bar: 'bar' }
  end

  describe 'drop' do
    before { oss.drop }
    it { expect(oss.raw).to eq [] }
  end

  describe 'raw' do
    it { expect(oss.raw).to eq ['osx'] }
  end
end


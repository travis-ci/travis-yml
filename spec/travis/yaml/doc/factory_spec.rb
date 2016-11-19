describe Travis::Yaml do
  let(:root)  { described_class.build(input) }
  let(:lang)  { root.children[0] }
  let(:os)    { root.children[1] }
  let(:dist)  { root.children[2] }
  let(:input) { { language: 'python' } }

  describe 'root' do
    it { expect(root).to be_a Travis::Yaml::Doc::Type::Map }
    it { expect(root.key).to eq :root }
    it { expect(root.children.map(&:key)).to eq [:language, :os, :dist, :sudo, :compiler] }
  end

  describe 'lang' do
    it { expect(lang).to be_a Travis::Yaml::Doc::Type::Fixed }
    it { expect(lang.key).to eq :language }
    it { expect(lang.value).to eq 'python' }
    it { expect(lang.opts.keys).to eq [:required, :defaults, :downcase, :alias, :values, :known, :given] }
    it { expect(lang.opts[:defaults]).to eq [value: 'ruby'] }
    it { expect(lang.opts[:downcase]).to be true }
    it { expect(lang.opts[:given]).to be true }
    it { expect(lang.opts[:known]).to be true }
    it { expect(lang.opts[:values]).to include(value: 'java', alias: ['jvm']) }
  end

  describe 'os' do
    it { expect(os).to be_a Travis::Yaml::Doc::Type::Seq }
    it { expect(os.key).to eq :os }
    it { expect(os.opts.keys).to eq [:required, :defaults, :types, :known] }
    it { expect(os.children).to be_empty }
    it { expect(os.opts[:known]).to be true }
  end

  describe 'dist' do
    it { expect(dist).to be_a Travis::Yaml::Doc::Type::Fixed }
    it { expect(dist.key).to eq :dist }
    it { expect(dist.opts.keys).to eq [:required, :defaults, :downcase, :values, :known] }
    it { expect(dist.opts[:defaults]).to eq [value: 'precise'] }
    it { expect(dist.opts[:downcase]).to be true }
    it { expect(dist.opts[:values].first).to eq(value: 'precise') }
    it { expect(dist.opts[:known]).to be true }
  end

  describe 'alias' do
    let(:input) { { lang: 'python' } }

    it { expect(lang).to be_a Travis::Yaml::Doc::Type::Fixed }
    it { expect(lang.key).to eq :language }
    it { expect(lang.value).to eq 'python' }
    it { expect(lang.opts.keys).to eq [:required, :defaults, :downcase, :alias, :values, :known, :given] }
    it { expect(lang.opts[:known]).to be true }
  end

  describe 'open map' do
    let(:input) { { foo: { bar: 'bar' } } }
    let(:foo)   { root.children.last }

    it { expect(foo).to be_a Travis::Yaml::Doc::Type::Map }
    it { expect(foo.key).to eq :foo }
    it { expect(foo.value).to eq(bar: 'bar') }
    it { expect(foo.known?).to be false }
    it { expect(foo.given?).to be true }
    it { expect(foo.strict?).to be false }
  end
end

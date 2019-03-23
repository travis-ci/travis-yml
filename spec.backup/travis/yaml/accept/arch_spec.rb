describe Travis::Yaml, 'arch' do
  let(:config) { subject.serialize }
  let(:arch)   { config[:arch] }
  let(:os)     { config[:os] }

  subject { described_class.apply(input) }

  describe 'defaults to nil' do
    let(:input) { { language: 'ruby' } }
    it { expect(arch).to be_nil }
    it { expect(msgs).to be_empty }
  end

  describe 'accepts amd64' do
    let(:input) { { arch: 'amd64' } }
    it { expect(arch).to eq ['amd64'] }
  end

  describe 'accepts alias x86_64' do
    let(:input) { { arch: 'x86_64' } }
    it { expect(arch).to eq ['amd64'] }
  end

  describe 'accepts ppc64le' do
    let(:input) { { arch: 'ppc64le' } }
    it { expect(arch).to eq ['ppc64le'] }
  end

  describe 'accepts alias power' do
    let(:input) { { arch: 'power' } }
    it { expect(arch).to eq ['ppc64le'] }
  end

  describe 'given a string' do
    let(:input) { { arch: 'string' } }
    it { expect(arch).to eq ['amd64'] }
  end

  describe 'no-op for os: osx' do
    let(:input) { { os: 'osx', arch: 'amd64' } }
    it { expect(arch).to be_nil }
    it { expect(msgs).to include( [:error, :arch, :unsupported, {:on_key=>:os, :on_value=>"osx", :key=>:arch, :value=>"amd64"}]) }
  end

  describe 'ignores case' do
    let(:input) { { arch: 'PPC64LE' } }
    it { expect(arch).to eq ['ppc64le'] }
  end

  describe 'given an array' do
    let(:input) { { arch: ['amd64', 'power'] } }
    it { expect(arch).to eq ['amd64', 'ppc64le'] }
  end

  describe 'drops unknown values' do
    let(:input) { { arch: 'forth' } }
    it { expect(arch).to eq ['amd64'] }
    it { expect(msgs).to include([:warn, :arch, :unknown_default, value: 'forth', default: 'amd64']) }
  end
end

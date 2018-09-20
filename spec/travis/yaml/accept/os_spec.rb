describe Travis::Yaml, 'os' do
  let(:config) { subject.serialize }
  let(:lang)   { config[:language] }
  let(:os)     { config[:os] }

  subject { described_class.apply(input) }

  describe 'defaults to linux' do
    let(:input) { { language: 'ruby' } }
    it { expect(os).to eq ['linux'] }
    it { expect(msgs).to be_empty }
  end

  describe 'given a string' do
    let(:input) { { os: 'osx' } }
    it { expect(os).to eq ['osx'] }
  end

  describe 'given an array' do
    let(:input) { { language: 'ruby', os: ['linux', 'osx'] } }
    it { expect(lang).to eq 'ruby' }
    it { expect(os).to eq ['linux', 'osx'] }
  end

  describe 'ignores case' do
    let(:input) { { os: 'LINUX' } }
    it { expect(os).to eq ['linux'] }
  end

  describe 'drops an unknown values' do
    let(:input) { { os: 'forth' } }
    it { expect(os).to eq ['linux'] }
    it { expect(msgs).to include([:warn, :os, :unknown_default, value: 'forth', default: 'linux']) }
  end

  describe 'supports aliases' do
    let(:input) { { os: ['ubuntu', 'macos'] } }
    it { expect(os).to eq ['linux', 'osx'] }
  end

  describe 'defaults to osx for objective_c' do
    let(:input) { { language: 'objc' } }
    it { expect(os).to eq ['osx'] }
    it { expect(msgs).to be_empty }
  end

  describe 'does not complain about the default os' do
    let(:input) { { language: 'objective-c' } }
    it { expect(msgs).to be_empty }
  end

  describe 'drops an os unsupported by the language' do
    let(:input) { { os: 'osx', language: 'php' } }
    it { expect(os).to eq ['linux'] }
    it { expect(msgs).to include [:error, :os, :unsupported, on_key: :language, on_value: 'php', key: :os, value: 'osx'] }
  end

  describe 'complains about jdk on osx' do
    let(:input) { { os: 'osx', language: 'java', jdk: 'default' } }
    it { expect(os).to eq ['osx'] }
    it { expect(msgs).to include [:error, :jdk, :unsupported, on_key: :os, on_value: 'osx', key: :jdk, value: ['default']] }
    it { expect(subject.serialize[:language]).to be == 'java' }
    it { expect(subject.serialize[:jdk]).to be_nil }
  end

  describe 'given a mixed, nested array' do
    let(:input) { { os: ['linux', os: 'osx'] } }
    it { expect(os).to eq ['linux'] }
    it { expect(msgs).to include [:error, :os, :invalid_type, expected: :str, actual: :map, value: { os: 'osx' }] }
  end

  describe 'given a mixed, nested array, with an unsupported key on root' do
    let(:input) { { osx_image: 'image', os: ['linux', os: 'osx'] } }
    it { expect(os).to eq ['linux'] }
    it { expect(msgs).to include [:error, :os, :invalid_type, expected: :str, actual: :map, value: { os: 'osx' }] }
    it { expect(msgs).to include [:error, :osx_image, :unsupported, on_key: :os, on_value: 'linux', key: :osx_image, value: 'image'] }
    it { expect(msgs.size).to eq 2 }
  end
end

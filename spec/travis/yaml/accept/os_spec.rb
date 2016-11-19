describe Travis::Yaml, 'os' do
  let(:msgs) { subject.msgs.reject { |msg| msg.first == :info } }
  let(:lang) { subject.to_h[:language] }
  let(:os)   { subject.to_h[:os] }

  subject { described_class.apply(input) }

  describe 'defaults to linux' do
    let(:input) { { language: 'ruby' } }
    it { expect(os).to eq ['linux'] }
    it { expect(msgs).to be_empty }
  end

  describe 'sets a valid os' do
    let(:input) { { os: 'osx' } }
    it { expect(os).to eq ['osx'] }
  end

  describe 'ignores case' do
    let(:input) { { os: 'LINUX' } }
    it { expect(os).to eq ['linux'] }
  end

  describe 'drops an unknown values' do
    let(:input) { { os: 'windows' } }
    it { expect(os).to eq ['linux'] }
    it { expect(msgs).to include([:error, :os, :unknown_value, 'dropping unknown value "windows"']) }
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
    let(:input) { { language: 'objective_c' } }
    it { expect(msgs).to be_empty }
  end

  describe 'drops an os unsupported by the language' do
    let(:input) { { os: 'osx', language: 'python' } }
    it { expect(os).to eq ['linux'] }
    it { expect(msgs).to include [:error, :os, :unsupported, 'os ("osx") is not supported on language "python"'] }
  end

  describe 'complains about jdk on osx' do
    let(:input) { { os: 'osx', language: 'java', jdk: 'default' } }
    it { expect(os).to eq ['osx'] }
    it { expect(msgs).to include [:error, :jdk, :unsupported, 'jdk ("default") is not supported on os "osx"'] }
    it { expect(subject.to_h[:language]).to be == 'java' }
    it { expect(subject.to_h[:jdk]).to be_nil }
  end

  describe 'foo' do
    let(:input) { { language: 'ruby', os: ['linux', 'osx'] } }
    it { expect(lang).to eq 'ruby' }
    it { expect(os).to eq ['linux', 'osx'] }
  end
end

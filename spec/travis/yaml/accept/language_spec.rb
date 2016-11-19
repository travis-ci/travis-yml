describe Travis::Yaml, 'language' do
  let(:msgs) { subject.msgs }
  let(:lang) { subject.to_h[:language] }

  subject { described_class.apply(config) }

  describe 'defaults to ruby' do
    let(:config) { {} }
    it { expect(lang).to eq 'ruby' }
    it { expect(msgs).to include([:info, :language, :default, 'missing :language, defaulting to "ruby"']) }
  end

  describe 'sets a valid language' do
    let(:config) { { language: 'java' } }
    it { expect(lang).to eq 'java' }
  end

  describe 'ignores case' do
    let(:config) { { language: 'JAVA' } }
    it { expect(lang).to eq 'java' }
  end

  describe 'drops an unknown language' do
    let(:config) { { language: 'sql' } }
    it { expect(lang).to eq 'ruby' }
    it { expect(msgs).to include([:warn, :language, :unknown_default, 'dropping unknown value "sql", defaulting to "ruby"']) }
  end

  describe 'supports the alias :lang' do
    let(:config) { { lang: 'ruby' } }
    it { expect(lang).to eq 'ruby' }
    it { expect(msgs).to include([:info, :root, :alias, '"lang" is an alias for "language", using "language"']) }
  end

  describe 'supports value aliases' do
    let(:config) { { language: 'jvm' } }
    it { expect(lang).to eq 'java' }
    it { expect(msgs).to include([:info, :language, :alias, '"jvm" is an alias for "java", using "java"']) }
  end

  describe 'supports arrays, but warns' do
    let(:config) { { language: ['jvm'] } }
    it { expect(lang).to eq 'java' }
    it { expect(msgs).to include([:warn, :language, :invalid_seq, 'unexpected sequence, using the first value ("jvm")']) }
  end
end

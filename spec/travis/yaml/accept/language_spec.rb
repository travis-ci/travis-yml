describe Travis::Yaml, 'language' do
  let(:lang) { subject.serialize[:language] }

  subject { described_class.apply(input) }

  describe 'defaults to ruby' do
    let(:input) { {} }
    it { expect(lang).to eq 'ruby' }
    it { expect(info).to include [:info, :language, :default, key: :language, default: 'ruby'] }
  end

  describe 'sets a valid language' do
    let(:input) { { language: 'java' } }
    it { expect(lang).to eq 'java' }
  end

  describe 'alias lang' do
    let(:input) { { lang: 'python' } }
    it { expect(lang).to eq 'python' }
  end

  describe 'ignores case' do
    let(:input) { { language: 'JAVA' } }
    it { expect(lang).to eq 'java' }
  end

  describe 'drops an unknown language' do
    let(:input) { { language: 'sql' } }
    it { expect(lang).to eq 'ruby' }
    it { expect(msgs).to include [:warn, :language, :unknown_default, value: 'sql', default: 'ruby'] }
  end

  describe 'drops an invalid type' do
    let(:input) { { language: { php: 'hhvm' } } }
    it { expect(lang).to eq 'ruby' }
    it { expect(msgs).to include [:error, :language, :invalid_type, expected: :str, actual: :map, value: { php: 'hhvm' }] }
    it { expect(info).to include [:info, :language, :default, key: :language, default: 'ruby'] }
  end

  describe 'supports value aliases' do
    let(:input) { { language: 'jvm' } }
    it { expect(lang).to eq 'java' }
    it { expect(info).to include [:info, :language, :alias, alias: 'jvm', value: 'java'] }
    it { expect(info).to_not include [:info, :language, :alias, alias: 'java', value: 'java'] }
  end

  describe 'supports value alias with an array' do
    let(:input) { { language: ['C++', 'java'] } }
    it { expect(lang).to eq 'cpp' }
    it { expect(msgs).to include [:warn, :language, :invalid_seq, value: 'C++'] }
    it { expect(info).to include [:info, :language, :alias, alias: 'c++', value: 'cpp'] }
  end

  describe 'supports arrays, but warns' do
    let(:input) { { language: ['jvm'] } }
    it { expect(lang).to eq 'java' }
    it { expect(msgs).to include [:warn, :language, :invalid_seq, value: 'jvm'] }
  end

  describe 'uppercased value' do
    let(:input) { { language: 'RUBY' } }
    it { expect(lang).to eq 'ruby' }
    it { expect(info).to include [:info, :language, :downcase, value: 'RUBY'] }
  end

  describe 'known value with extra special chars' do
    let(:input) { { language: 'ruby!' } }
    it { expect(lang).to eq 'ruby' }
    it { expect(msgs).to include [:warn, :language, :find_value, original: 'ruby!', value: 'ruby'] }
  end

  describe 'uppercased aliased value with non-word chars' do
    let(:input) { { language: 'C++' } }
    it { expect(lang).to eq 'cpp' }
  end

  describe 'unexpected seq with an aliased value' do
    let(:input) { { language: ['C++', 'java'] } }
    it { expect(lang).to eq 'cpp' }
  end

  describe 'unexpected seq with an uppercased value' do
    let(:input) { { language: ['C'] } }
    it { expect(lang).to eq 'c' }
  end
end

describe Travis::Yaml do
  let(:lang)  { subject.serialize[:language] }
  let(:input) { { language: 'cpp' } }

  subject { described_class.apply(input) }

  describe 'cpp' do
    let(:input) { { language: 'cpp' } }
    it { expect(lang).to eq 'cpp' }
  end

  describe 'alias c++' do
    let(:input) { { language: 'c++' } }
    it { expect(lang).to eq 'cpp' }
    it { expect(info).to include [:info, :language, :alias, alias: 'c++', value: 'cpp'] }
  end

  describe 'alias C++' do
    let(:input) { { language: 'C++' } }
    it { expect(lang).to eq 'cpp' }
    it { expect(info).to include [:info, :language, :downcase, value: 'C++'] }
    it { expect(info).to include [:info, :language, :alias, alias: 'c++', value: 'cpp'] }
  end
end

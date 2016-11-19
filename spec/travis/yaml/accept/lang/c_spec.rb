describe Travis::Yaml do
  let(:lang)   { subject.serialize[:language] }
  let(:input)  { { language: 'c' } }
  let(:config) { subject.serialize }

  subject { described_class.apply(input) }

  it { expect(config[:language]).to eq 'c' }
end

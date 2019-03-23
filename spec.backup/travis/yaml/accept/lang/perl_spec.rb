describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'perl', perl: '5.24' } }

  it { expect(config[:language]).to eq 'perl' }
  it { expect(config[:perl]).to eq ['5.24'] }
end

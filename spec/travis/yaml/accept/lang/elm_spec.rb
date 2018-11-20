describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'elm', elm: '0.19.0' } }

  it { expect(config[:language]).to eq 'elm' }
  it { expect(config[:elm]).to eq ['0.19.0'] }
end

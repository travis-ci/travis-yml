describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'crystal', crystal: '0.16.0' } }

  it { expect(config[:language]).to eq 'crystal' }
  it { expect(config[:crystal]).to eq ['0.16.0'] }
end

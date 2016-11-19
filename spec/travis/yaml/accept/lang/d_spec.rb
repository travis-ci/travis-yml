describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'd', d: '2.072.0' } }

  it { expect(config[:language]).to eq 'd' }
  it { expect(config[:d]).to eq ['2.072.0'] }
end

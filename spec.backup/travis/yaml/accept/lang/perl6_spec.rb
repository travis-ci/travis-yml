describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'perl6', perl6: 'latest' } }

  it { expect(config[:language]).to eq 'perl6' }
  it { expect(config[:perl6]).to eq ['latest'] }
end

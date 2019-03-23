describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'haskell', ghc: '7.8'  } }

  it { expect(config[:language]).to eq 'haskell' }
  it { expect(config[:ghc]).to eq ['7.8'] }
end

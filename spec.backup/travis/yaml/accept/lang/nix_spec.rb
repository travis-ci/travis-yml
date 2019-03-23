describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'nix'  } }

  it { expect(config[:language]).to eq 'nix' }
end

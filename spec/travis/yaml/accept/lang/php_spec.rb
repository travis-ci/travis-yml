describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'php', php: '7.1', composer_args: 'args' } }

  it { expect(config[:language]).to eq 'php' }
  it { expect(config[:php]).to eq ['7.1'] }
  it { expect(config[:composer_args]).to eq 'args' }
end

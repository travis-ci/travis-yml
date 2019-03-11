describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'hack', hhvm: 'hhvm', php: '7.3' } }

  it { expect(config[:language]).to eq 'hack' }
  it { expect(config[:hhvm]).to eq ['hhvm'] }
  it { expect(config[:php]).to eq ['7.3'] }
end

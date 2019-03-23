describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'rust', rust: '1.13.0' } }

  it { expect(config[:language]).to eq 'rust' }
  it { expect(config[:rust]).to eq ['1.13.0'] }
end

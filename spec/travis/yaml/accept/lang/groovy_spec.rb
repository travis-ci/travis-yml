describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'groovy', jdk: ['default'], lein: 'lein1' } }

  it { expect(config[:language]).to eq 'groovy' }
  it { expect(config[:jdk]).to eq ['default'] }
end

describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'scala', scala: ['2.12.0'], jdk: ['default'], sbt_args: 'args' } }

  it { expect(config[:language]).to eq 'scala' }
  it { expect(config[:scala]).to eq ['2.12.0'] }
  it { expect(config[:jdk]).to eq ['default'] }
  it { expect(config[:sbt_args]).to eq 'args' }
end

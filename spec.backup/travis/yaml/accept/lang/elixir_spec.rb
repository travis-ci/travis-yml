describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'elixir', elixir: '1.3.4', otp_release: '18.2.1' } }

  it { expect(config[:language]).to eq 'elixir' }
  it { expect(config[:elixir]).to eq ['1.3.4'] }
  it { expect(config[:otp_release]).to eq ['18.2.1'] }
end

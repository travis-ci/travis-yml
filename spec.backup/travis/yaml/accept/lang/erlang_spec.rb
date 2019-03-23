describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'erlang', otp_release: '18.2.1' } }

  it { expect(config[:language]).to eq 'erlang' }
  it { expect(config[:otp_release]).to eq ['18.2.1'] }
end

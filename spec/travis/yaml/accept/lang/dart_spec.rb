describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'dart', dart: '1.20.1', with_content_shell: true } }

  it { expect(config[:language]).to eq 'dart' }
  it { expect(config[:dart]).to eq ['1.20.1'] }
  it { expect(config[:with_content_shell]).to eq true }
end

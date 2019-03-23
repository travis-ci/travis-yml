describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'haxe', haxe: '3.2.1', hxml: ['build.hxml'], neko: '2.0.0' } }

  it { expect(config[:language]).to eq 'haxe' }
  it { expect(config[:haxe]).to eq ['3.2.1'] }
  it { expect(config[:hxml]).to eq ['build.hxml'] }
  it { expect(config[:neko]).to eq '2.0.0' }
end

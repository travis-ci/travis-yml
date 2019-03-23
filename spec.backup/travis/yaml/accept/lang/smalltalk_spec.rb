describe Travis::Yaml do
  let(:config) { described_class.apply(input).serialize }
  let(:input)  { { language: 'smalltalk', smalltalk: 'Squeak-5.0', smalltalk_config: 'my.ston', smalltalk_edge: true } }

  it { expect(config[:language]).to eq 'smalltalk' }
  it { expect(config[:smalltalk]).to eq ['Squeak-5.0'] }
  it { expect(config[:smalltalk_config]).to eq ['my.ston'] }
  it { expect(config[:smalltalk_edge]).to eq true }
end

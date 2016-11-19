describe Travis::Yaml::Doc::Conform do
  let(:msgs)  { node.msgs }
  let(:node)  { Travis::Yaml.build(input) }
  let(:input) { { language: 'java' } }

  before  { described_class.apply(node) }

  it { expect(node.to_h).to eq(language: 'java', os: ['linux'], dist: 'precise', sudo: false) }
end

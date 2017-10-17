describe Travis::Yaml, 'stages' do
  let(:stages) { subject.serialize[:stages] }

  subject { described_class.apply(config) }

  describe 'given an array of strings' do
    let(:config) { { stages: ['one'] } }
    it { expect(stages).to eq [name: 'one'] }
  end

  describe 'given an array of hashes' do
    let(:config) { { stages: [name: 'one', if: 'branch = main'] } }
    it { expect(stages).to eq [name: 'one', if: 'branch = main'] }
  end
end

describe Travis::Yaml, 'group' do
  let(:group) { subject.serialize[:group] }

  subject { described_class.apply(config) }

  describe 'set group value' do
    let(:config) { { group: 'stable' } }
    it { expect(group).to eq 'stable' }
  end

  describe 'set arbitrary group value' do
    let(:config) { { group: 'arbitrary' } }
    it { expect(group).to eq 'arbitrary' }
  end
end

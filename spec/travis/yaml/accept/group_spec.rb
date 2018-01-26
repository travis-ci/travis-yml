describe Travis::Yaml, 'group' do
  let(:group) { subject.serialize[:group] }

  subject { described_class.apply(config) }

  describe 'set group value' do
    let(:config) { { group: 'stable' } }
    it { expect(group).to eq 'stable' }
  end

  describe 'adds msgs about feature flags' do
    let(:config) { { group: 'stable' } }
    it { expect(info).to include [:info, :group, :flagged, given: :group] }
  end
end

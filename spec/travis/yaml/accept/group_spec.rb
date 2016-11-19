describe Travis::Yaml, 'group' do
  let(:msgs)  { subject.msgs }
  let(:group) { subject.to_h[:group] }

  subject { described_class.apply(config) }

  describe 'set group value' do
    let(:config) { { group: 'stable' } }
    it { expect(group).to eq 'stable' }
  end

  describe 'adds msgs about feature flags' do
    let(:config) { { group: 'stable' } }
    it { expect(msgs).to include [:info, :group, :flagged, 'your repository must be feature flagged for :group to be used'] }
  end
end

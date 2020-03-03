describe Travis::Yml, 'group' do
  subject { described_class.load(yaml) }

  describe 'stable' do
    yaml %(
      group: stable
    )
    it { should serialize_to group: 'stable' }
  end

  describe 'arbitrary' do
    yaml %(
      group: arbitrary
    )
    it { should serialize_to group: 'arbitrary' }
  end
end

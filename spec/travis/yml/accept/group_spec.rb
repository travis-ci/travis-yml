describe Travis::Yml, 'group' do
  subject { described_class.apply(parse(yaml)) }

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

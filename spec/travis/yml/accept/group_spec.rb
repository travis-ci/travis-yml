describe Travis::Yml do
  accept 'group' do
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
end

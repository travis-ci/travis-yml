describe Travis::Yml, 'matlab' do
  subject { described_class.load(yaml) }

  describe 'matlab' do
    describe 'given a seq of strs' do
      yaml %(
        matlab:
        - str
      )
      it { should serialize_to matlab: ['str'] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        matlab: str
      )
      it { should serialize_to matlab: ['str'] }
      it { should_not have_msg }
    end
  end
end

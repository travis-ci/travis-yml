describe Travis::Yml, 'crystal' do
  subject { described_class.load(yaml) }
  
  describe 'crystal' do
    describe 'given a seq of strs' do
      yaml %(
        crystal:
        - str
      )
      it { should serialize_to crystal: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        crystal: str
      )
      it { should serialize_to crystal: ['str'] }
      it { should_not have_msg }
    end
  end
end

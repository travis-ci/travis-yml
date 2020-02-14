describe Travis::Yml, 'd' do
  subject { described_class.load(yaml) }
  
  describe 'd' do
    describe 'given a seq of strs' do
      yaml %(
        d:
        - str
      )
      it { should serialize_to d: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        d: str
      )
      it { should serialize_to d: ['str'] }
      it { should_not have_msg }
    end
  end
end

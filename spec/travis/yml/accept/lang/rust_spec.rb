describe Travis::Yml, 'rust' do
  subject { described_class.load(yaml) }
  
  describe 'rust' do
    describe 'given a seq of strs' do
      yaml %(
        rust:
        - str
      )
      it { should serialize_to rust: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        rust: str
      )
      it { should serialize_to rust: ['str'] }
      it { should_not have_msg }
    end
  end
end

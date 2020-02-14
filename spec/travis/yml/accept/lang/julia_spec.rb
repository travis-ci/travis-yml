describe Travis::Yml, 'julia' do
  subject { described_class.load(yaml) }
  
  describe 'julia' do
    describe 'given a seq of strs' do
      yaml %(
        julia:
        - str
      )
      it { should serialize_to julia: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        julia: str
      )
      it { should serialize_to julia: ['str'] }
      it { should_not have_msg }
    end
  end
end

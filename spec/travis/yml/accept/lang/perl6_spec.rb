describe Travis::Yml, 'perl6' do
  subject { described_class.apply(parse(yaml)) }
  
  describe 'perl6' do
    describe 'given a seq of strs' do
      yaml %(
        perl6:
        - str
      )
      it { should serialize_to perl6: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        perl6: str
      )
      it { should serialize_to perl6: ['str'] }
      it { should_not have_msg }
    end
  end
end

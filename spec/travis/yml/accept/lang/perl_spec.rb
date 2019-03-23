describe Travis::Yml, 'perl' do
  subject { described_class.apply(parse(yaml)) }
  
  describe 'perl' do
    describe 'given a seq of strs' do
      yaml %(
        perl:
        - str
      )
      it { should serialize_to perl: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        perl: str
      )
      it { should serialize_to perl: ['str'] }
      it { should_not have_msg }
    end
  end
end

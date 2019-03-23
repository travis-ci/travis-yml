describe Travis::Yml, 'haskell' do
  subject { described_class.apply(parse(yaml)) }
  
  describe 'ghc' do
    describe 'given a seq of strs' do
      yaml %(
        ghc:
        - str
      )
      it { should serialize_to ghc: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        ghc: str
      )
      it { should serialize_to ghc: ['str'] }
      it { should_not have_msg }
    end
  end
end

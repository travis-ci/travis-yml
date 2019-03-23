describe Travis::Yml, 'java' do
  subject { described_class.apply(parse(yaml)) }
  
  describe 'jdk' do
    describe 'given a seq of strs' do
      yaml %(
        jdk:
        - str
      )
      it { should serialize_to jdk: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        jdk: str
      )
      it { should serialize_to jdk: ['str'] }
      it { should_not have_msg }
    end
  end
end

describe Travis::Yml, 'clojure' do
  subject { described_class.load(yaml) }
  
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
  
  describe 'lein' do
    describe 'given a str' do
      yaml %(
        lein: str
      )
      it { should serialize_to lein: 'str' }
    end
  end
end

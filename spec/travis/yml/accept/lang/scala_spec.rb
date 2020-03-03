describe Travis::Yml, 'scala' do
  subject { described_class.load(yaml) }
  
  describe 'scala' do
    describe 'given a seq of strs' do
      yaml %(
        scala:
        - str
      )
      it { should serialize_to scala: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        scala: str
      )
      it { should serialize_to scala: ['str'] }
      it { should_not have_msg }
    end
  end
  
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
  
  describe 'sbt_args' do
    describe 'given a str' do
      yaml %(
        sbt_args: str
      )
      it { should serialize_to sbt_args: 'str' }
    end
  end
end

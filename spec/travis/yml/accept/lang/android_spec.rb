describe Travis::Yml, 'android' do
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
  
  describe 'android' do
    describe 'components' do
      describe 'given a seq of strs' do
        yaml %(
          android:
            components:
            - str
        )
        it { should serialize_to android: { components: ['str'] } }
        it { should_not have_msg }
      end
      
      describe 'given a str' do
        yaml %(
          android:
            components: str
        )
        it { should serialize_to android: { components: ['str'] } }
        it { should_not have_msg }
      end
    end
    
    describe 'licenses' do
      describe 'given a seq of strs' do
        yaml %(
          android:
            licenses:
            - str
        )
        it { should serialize_to android: { licenses: ['str'] } }
        it { should_not have_msg }
      end
      
      describe 'given a str' do
        yaml %(
          android:
            licenses: str
        )
        it { should serialize_to android: { licenses: ['str'] } }
        it { should_not have_msg }
      end
    end
  end
end

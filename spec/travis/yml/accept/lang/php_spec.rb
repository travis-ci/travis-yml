describe Travis::Yml, 'php' do
  subject { described_class.apply(parse(yaml)) }
  
  describe 'php' do
    describe 'given a seq of strs' do
      yaml %(
        php:
        - str
      )
      it { should serialize_to php: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        php: str
      )
      it { should serialize_to php: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'composer_args' do
    describe 'given a str' do
      yaml %(
        composer_args: str
      )
      it { should serialize_to composer_args: 'str' }
    end
  end
end

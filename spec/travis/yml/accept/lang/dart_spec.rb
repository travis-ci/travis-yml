describe Travis::Yml, 'dart' do
  subject { described_class.apply(parse(yaml)) }
  
  describe 'dart' do
    describe 'given a seq of strs' do
      yaml %(
        dart:
        - str
      )
      it { should serialize_to dart: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        dart: str
      )
      it { should serialize_to dart: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'with_content_shell' do
    describe 'given a bool' do
      yaml %(
        with_content_shell: true
      )
      it { should serialize_to with_content_shell: true }
    end
  end
end

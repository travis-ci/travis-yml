describe Travis::Yml, 'haxe' do
  subject { described_class.load(yaml) }
  
  describe 'haxe' do
    describe 'given a seq of strs' do
      yaml %(
        haxe:
        - str
      )
      it { should serialize_to haxe: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        haxe: str
      )
      it { should serialize_to haxe: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'hxml' do
    describe 'given a seq of strs' do
      yaml %(
        hxml:
        - str
      )
      it { should serialize_to hxml: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        hxml: str
      )
      it { should serialize_to hxml: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'neko' do
    describe 'given a str' do
      yaml %(
        neko: str
      )
      it { should serialize_to neko: 'str' }
    end
  end
end

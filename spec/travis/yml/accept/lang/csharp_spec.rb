describe Travis::Yml, 'csharp' do
  subject { described_class.apply(parse(yaml)) }
  
  describe 'dotnet' do
    describe 'given a seq of strs' do
      yaml %(
        dotnet:
        - str
      )
      it { should serialize_to dotnet: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        dotnet: str
      )
      it { should serialize_to dotnet: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'mono' do
    describe 'given a seq of strs' do
      yaml %(
        mono:
        - str
      )
      it { should serialize_to mono: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        mono: str
      )
      it { should serialize_to mono: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'solution' do
    describe 'given a seq of strs' do
      yaml %(
        solution:
        - str
      )
      it { should serialize_to solution: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        solution: str
      )
      it { should serialize_to solution: ['str'] }
      it { should_not have_msg }
    end
  end
end

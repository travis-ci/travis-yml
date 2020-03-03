describe Travis::Yml, 'objective_c' do
  subject { described_class.load(yaml) }
  
  describe 'rvm' do
    describe 'given a seq of strs' do
      yaml %(
        rvm:
        - str
      )
      it { should serialize_to rvm: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        rvm: str
      )
      it { should serialize_to rvm: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'gemfile' do
    describe 'given a seq of strs' do
      yaml %(
        gemfile:
        - str
      )
      it { should serialize_to gemfile: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        gemfile: str
      )
      it { should serialize_to gemfile: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'xcode_scheme' do
    describe 'given a seq of strs' do
      yaml %(
        xcode_scheme:
        - str
      )
      it { should serialize_to xcode_scheme: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        xcode_scheme: str
      )
      it { should serialize_to xcode_scheme: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'xcode_sdk' do
    describe 'given a seq of strs' do
      yaml %(
        xcode_sdk:
        - str
      )
      it { should serialize_to xcode_sdk: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        xcode_sdk: str
      )
      it { should serialize_to xcode_sdk: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'podfile' do
    describe 'given a str' do
      yaml %(
        podfile: str
      )
      it { should serialize_to podfile: 'str' }
    end
  end
  
  describe 'bundler_args' do
    describe 'given a str' do
      yaml %(
        bundler_args: str
      )
      it { should serialize_to bundler_args: 'str' }
    end
  end
  
  describe 'xcode_project' do
    describe 'given a str' do
      yaml %(
        xcode_project: str
      )
      it { should serialize_to xcode_project: 'str' }
    end
  end
  
  describe 'xcode_workspace' do
    describe 'given a str' do
      yaml %(
        xcode_workspace: str
      )
      it { should serialize_to xcode_workspace: 'str' }
    end
  end
  
  describe 'xctool_args' do
    describe 'given a str' do
      yaml %(
        xctool_args: str
      )
      it { should serialize_to xctool_args: 'str' }
    end
  end
end

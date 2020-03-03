describe Travis::Yml, 'go' do
  subject { described_class.load(yaml) }
  
  describe 'go' do
    describe 'given a seq of strs' do
      yaml %(
        go:
        - str
      )
      it { should serialize_to go: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        go: str
      )
      it { should serialize_to go: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'gobuild_args' do
    describe 'given a str' do
      yaml %(
        gobuild_args: str
      )
      it { should serialize_to gobuild_args: 'str' }
    end
  end
  
  describe 'go_import_path' do
    describe 'given a str' do
      yaml %(
        go_import_path: str
      )
      it { should serialize_to go_import_path: 'str' }
    end
  end
  
  describe 'gimme_config' do
    describe 'url' do
      describe 'given a str' do
        yaml %(
          gimme_config:
            url: str
        )
        it { should serialize_to gimme_config: { url: 'str' } }
      end
    end
    
    describe 'force_reinstall' do
      describe 'given a bool' do
        yaml %(
          gimme_config:
            force_reinstall: true
        )
        it { should serialize_to gimme_config: { force_reinstall: true } }
      end
    end
  end
end

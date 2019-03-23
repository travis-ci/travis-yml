describe Travis::Yml, 'python' do
  subject { described_class.apply(parse(yaml)) }
  
  describe 'python' do
    describe 'given a seq of strs' do
      yaml %(
        python:
        - str
      )
      it { should serialize_to python: ['str'] }
      it { should_not have_msg }
    end
    
    describe 'given a str' do
      yaml %(
        python: str
      )
      it { should serialize_to python: ['str'] }
      it { should_not have_msg }
    end
  end
  
  describe 'virtualenv' do
    describe 'system_site_packages' do
      describe 'given a bool' do
        yaml %(
          virtualenv:
            system_site_packages: true
        )
        it { should serialize_to virtualenv: { system_site_packages: true } }
      end
    end
  end
end

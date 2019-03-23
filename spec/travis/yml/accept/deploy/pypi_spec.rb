describe Travis::Yml, 'pypi' do
  subject { described_class.apply(parse(yaml)) }

  describe 'user' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pypi
          user:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'pypi', user: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pypi
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'pypi', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pypi
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'pypi', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'server' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pypi
          server: str
      )
      it { should serialize_to deploy: [provider: 'pypi', server: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'distributions' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pypi
          distributions: str
      )
      it { should serialize_to deploy: [provider: 'pypi', distributions: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'docs_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pypi
          docs_dir: str
      )
      it { should serialize_to deploy: [provider: 'pypi', docs_dir: 'str'] }
      it { should_not have_msg }
    end
  end
end

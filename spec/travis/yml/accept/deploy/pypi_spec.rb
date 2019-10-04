describe Travis::Yml, 'pypi' do
  subject { described_class.apply(parse(yaml)) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pypi
          username:
            secure: str
      )
      it { should serialize_to deploy: [provider: 'pypi', username: { secure: 'str' }] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: pypi
          username: str
      )
      it { should serialize_to deploy: [provider: 'pypi', username: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'user (alias)' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: pypi
          user:
            secure: str
      )
      it { should serialize_to deploy: [provider: 'pypi', username: { secure: 'str' }] }
      it { should have_msg [:info, :deploy, :alias_key, alias: 'user', key: 'username', provider: 'pypi'] }
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

  describe 'setuptools_version' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pypi
          setuptools_version: str
      )
      it { should serialize_to deploy: [provider: 'pypi', setuptools_version: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'twine_version' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pypi
          twine_version: str
      )
      it { should serialize_to deploy: [provider: 'pypi', twine_version: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'wheel_version' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: pypi
          wheel_version: str
      )
      it { should serialize_to deploy: [provider: 'pypi', wheel_version: 'str'] }
      it { should_not have_msg }
    end
  end
end

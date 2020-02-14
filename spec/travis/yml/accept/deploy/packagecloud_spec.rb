describe Travis::Yml, 'packagecloud' do
  subject { described_class.load(yaml) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: packagecloud
          username:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'packagecloud', username: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: packagecloud
          token:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'packagecloud', token: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'repository' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: packagecloud
          repository: str
      )
      it { should serialize_to deploy: [provider: 'packagecloud', repository: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'local_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: packagecloud
          local_dir: str
      )
      it { should serialize_to deploy: [provider: 'packagecloud', local_dir: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'dist' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: packagecloud
          dist: str
      )
      it { should serialize_to deploy: [provider: 'packagecloud', dist: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'package_glob' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: packagecloud
          package_glob: str
      )
      it { should serialize_to deploy: [provider: 'packagecloud', package_glob: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'force' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: packagecloud
          force: true
      )
      it { should serialize_to deploy: [provider: 'packagecloud', force: true] }
      it { should_not have_msg }
    end
  end

  describe 'connect_timeout' do
    describe 'given a num' do
      yaml %(
        deploy:
          provider: packagecloud
          connect_timeout: 1
      )
      it { should serialize_to deploy: [provider: 'packagecloud', connect_timeout: 1] }
      it { should_not have_msg }
    end
  end

  describe 'read_timeout' do
    describe 'given a num' do
      yaml %(
        deploy:
          provider: packagecloud
          read_timeout: 1
      )
      it { should serialize_to deploy: [provider: 'packagecloud', read_timeout: 1] }
      it { should_not have_msg }
    end
  end

  describe 'write_timeout' do
    describe 'given a num' do
      yaml %(
        deploy:
          provider: packagecloud
          write_timeout: 1
      )
      it { should serialize_to deploy: [provider: 'packagecloud', write_timeout: 1] }
      it { should_not have_msg }
    end
  end
end

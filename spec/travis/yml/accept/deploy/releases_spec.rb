describe Travis::Yml, 'releases' do
  subject { described_class.apply(parse(yaml)) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: releases
          username:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'releases', username: { secure: 'secure' }] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: releases
          username: str
      )
      it { should serialize_to deploy: [provider: 'releases', username: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'user (alias)' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: releases
          user:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'releases', username: { secure: 'secure' }] }
      it { should have_msg [:info, :deploy, :alias, type: :key, alias: 'user', obj: 'username', provider: 'releases'] }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: releases
          user: str
      )
      it { should serialize_to deploy: [provider: 'releases', username: 'str'] }
      it { should have_msg [:info, :deploy, :alias, type: :key, alias: 'user', obj: 'username', provider: 'releases'] }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: releases
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'releases', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: releases
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'releases', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'repo' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: releases
          repo: str
      )
      it { should serialize_to deploy: [provider: 'releases', repo: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'file' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: releases
          file:
          - str
      )
      it { should serialize_to deploy: [provider: 'releases', file: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: releases
          file: str
      )
      it { should serialize_to deploy: [provider: 'releases', file: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'file_glob' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: releases
          file_glob: true
      )
      it { should serialize_to deploy: [provider: 'releases', file_glob: true] }
      it { should_not have_msg }
    end
  end

  describe 'overwrite' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: releases
          overwrite: true
      )
      it { should serialize_to deploy: [provider: 'releases', overwrite: true] }
      it { should_not have_msg }
    end
  end

  describe 'release_number' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: releases
          release_number: str
      )
      it { should serialize_to deploy: [provider: 'releases', release_number: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'prerelease' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: releases
          prerelease: true
      )
      it { should serialize_to deploy: [provider: 'releases', prerelease: true] }
      it { should_not have_msg }
    end
  end
end

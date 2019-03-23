describe Travis::Yml, 'atlas' do
  subject { described_class.apply(parse(yaml)) }

  describe 'token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: atlas
          token:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'atlas', token: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: atlas
          app: str
      )
      it { should serialize_to deploy: [provider: 'atlas', app: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'exclude' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: atlas
          exclude:
          - str
      )
      it { should serialize_to deploy: [provider: 'atlas', exclude: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: atlas
          exclude: str
      )
      it { should serialize_to deploy: [provider: 'atlas', exclude: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'include' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: atlas
          include:
          - str
      )
      it { should serialize_to deploy: [provider: 'atlas', include: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: atlas
          include: str
      )
      it { should serialize_to deploy: [provider: 'atlas', include: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'address' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: atlas
          address: str
      )
      it { should serialize_to deploy: [provider: 'atlas', address: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'vcs' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: atlas
          vcs: true
      )
      it { should serialize_to deploy: [provider: 'atlas', vcs: true] }
      it { should_not have_msg }
    end
  end

  describe 'metadata' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: atlas
          metadata:
          - str
      )
      it { should serialize_to deploy: [provider: 'atlas', metadata: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: atlas
          metadata: str
      )
      it { should serialize_to deploy: [provider: 'atlas', metadata: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'debug' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: atlas
          debug: true
      )
      it { should serialize_to deploy: [provider: 'atlas', debug: true] }
      it { should_not have_msg }
    end
  end

  describe 'version' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: atlas
          version: str
      )
      it { should serialize_to deploy: [provider: 'atlas', version: 'str'] }
      it { should_not have_msg }
    end
  end
end

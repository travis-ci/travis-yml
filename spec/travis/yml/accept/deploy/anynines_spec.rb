describe Travis::Yml, 'anynines' do
  subject { described_class.apply(parse(yaml)) }

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: anynines
          username:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'anynines', username: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: anynines
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'anynines', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'organization' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: anynines
          organization: str
      )
      it { should serialize_to deploy: [provider: 'anynines', organization: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'space' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: anynines
          space: str
      )
      it { should serialize_to deploy: [provider: 'anynines', space: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'manifest' do
    describe 'given a str' do
      yaml %(
        deploy:
          - provider: anynines
            manifest: str
      )

      it { should serialize_to deploy: [provider: 'anynines', manifest: 'str'] }
      it { should_not have_msg }
    end
  end
end

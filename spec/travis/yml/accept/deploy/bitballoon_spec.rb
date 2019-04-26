describe Travis::Yml, 'bitballoon' do
  subject { described_class.apply(parse(yaml)) }

  describe 'access_token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: bitballoon
          access-token:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'bitballoon', 'access-token': { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'site_id' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bitballoon
          site-id: str
      )
      it { should serialize_to deploy: [provider: 'bitballoon', 'site-id': 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'local_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bitballoon
          local-dir: str
      )
      it { should serialize_to deploy: [provider: 'bitballoon', 'local-dir': 'str'] }
      it { should_not have_msg }
    end
  end
end

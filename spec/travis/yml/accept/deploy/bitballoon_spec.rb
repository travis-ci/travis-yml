describe Travis::Yml, 'bitballoon' do
  subject { described_class.apply(parse(yaml)) }

  describe 'access_token' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: bitballoon
          access_token:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'bitballoon', access_token: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'site_id' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bitballoon
          site_id: str
      )
      it { should serialize_to deploy: [provider: 'bitballoon', site_id: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'local_dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: bitballoon
          local_dir: str
      )
      it { should serialize_to deploy: [provider: 'bitballoon', local_dir: 'str'] }
      it { should_not have_msg }
    end
  end
end

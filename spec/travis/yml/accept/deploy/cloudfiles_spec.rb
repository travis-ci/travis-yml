describe Travis::Yml, 'cloudfiles' do
  subject { described_class.apply(parse(yaml)) }


  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cloudfiles
          username:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'cloudfiles', username: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cloudfiles
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'cloudfiles', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'region' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudfiles
          region: str
      )
      it { should serialize_to deploy: [provider: 'cloudfiles', region: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'container' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudfiles
          container: str
      )
      it { should serialize_to deploy: [provider: 'cloudfiles', container: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'dot_match' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: cloudfiles
          dot_match: true
      )
      it { should serialize_to deploy: [provider: 'cloudfiles', dot_match: true] }
      it { should_not have_msg }
    end
  end
end

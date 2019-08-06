describe Travis::Yml, 'netlify' do
  subject { described_class.apply(parse(yaml)) }

  describe 'auth' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: netlify
          auth:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'netlify', 'auth': { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'site' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: netlify
          site: str
      )
      it { should serialize_to deploy: [provider: 'netlify', 'site': 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'dir' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: netlify
          dir: str
      )
      it { should serialize_to deploy: [provider: 'netlify', 'dir': 'str'] }
      it { should_not have_msg }
    end
  end
end

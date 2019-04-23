describe Travis::Yml, 'launchpad' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'slug, oauth_token, and oauth_token_secret' do
    describe 'given strs' do
      yaml %(
        deploy:
          provider: launchpad
          slug: str
          oauth_token: str
          oauth_token_secret: str
      )
      it { should serialize_to deploy: [provider: 'launchpad', slug: 'str', oauth_token: 'str', oauth_token_secret: 'str'] }
      it { should_not have_msg }
    end

    describe 'given secures' do
      yaml %(
        deploy:
          provider: launchpad
          slug: str
          oauth_token:
            secure: secure
          oauth_token_secret:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'launchpad', slug: 'str', oauth_token: { secure: 'secure' }, oauth_token_secret: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'missing slug', defaults: true do
    yaml %(
      deploy:
        provider: launchpad
        oauth_token: str
        oauth_token_secret: str
    )
    it { should serialize_to defaults }
    it { should have_msg [:error, :deploy, :required, key: :slug] }
    it { should_not have_msg [:error, :deploy, :required, key: :oauth_token] }
  end

  describe 'missing oauth_token', defaults: true do
    yaml %(
      deploy:
        provider: launchpad
        slug: str
        oauth_token_secret: str
    )
    it { should serialize_to defaults }
    it { should_not have_msg [:error, :deploy, :required, key: :slug] }
    it { should have_msg [:error, :deploy, :required, key: :oauth_token] }
  end

  describe 'missing oauth_token_secret', defaults: true do
    yaml %(
      deploy:
        provider: launchpad
        slug: str
        oauth_token: str
    )
    it { should serialize_to defaults }
    it { should_not have_msg [:error, :deploy, :required, key: :slug] }
    it { should have_msg [:error, :deploy, :required, key: :oauth_token_secret] }
  end
end

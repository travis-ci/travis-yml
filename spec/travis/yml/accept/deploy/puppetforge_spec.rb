describe Travis::Yml, 'puppetforge' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'user, password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: puppetforge
          user:
            secure: secure
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'puppetforge', user: { secure: 'secure' }, password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'missing user', defaults: true do
    yaml %(
      deploy:
        provider: puppetforge
        password: str
    )
    it { should serialize_to defaults }
    it { should have_msg [:error, :deploy, :required, key: :user] }
    it { should_not have_msg [:error, :deploy, :required, key: :password] }
  end

  describe 'missing password', defaults: true do
    yaml %(
      deploy:
        provider: puppetforge
        user: str
    )
    it { should serialize_to defaults }
    it { should_not have_msg [:error, :deploy, :required, key: :user] }
    it { should have_msg [:error, :deploy, :required, key: :password] }
  end

  describe 'url' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: puppetforge
          user: str
          password: str
          url: str
      )
      it { should serialize_to deploy: [provider: 'puppetforge', user: 'str', password: 'str', url: 'str'] }
      it { should_not have_msg }
    end
  end
end

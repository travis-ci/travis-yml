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
    it { should serialize_to **defaults, deploy: [provider: 'puppetforge', password: 'str'] }
    it { should have_msg [:error, :deploy, :required, key: 'user', provider: 'puppetforge'] }
    it { should_not have_msg [:error, :deploy, :required, key: 'password', provider: 'puppetforge'] }
  end

  describe 'missing password', defaults: true do
    yaml %(
      deploy:
        provider: puppetforge
        user: str
    )
    it { should serialize_to **defaults, deploy: [provider: 'puppetforge', user: 'str'] }
    it { should_not have_msg [:error, :deploy, :required, key: 'user', provider: 'puppetforge'] }
    it { should have_msg [:error, :deploy, :required, key: 'password', provider: 'puppetforge'] }
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
      it { should_not have_msg [:alert, :'deploy.user', :secure, type: :str] }
      it { should have_msg [:alert, :'deploy.password', :secure, type: :str] }
    end
  end
end

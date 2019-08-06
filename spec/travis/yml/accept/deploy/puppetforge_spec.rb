describe Travis::Yml, 'puppetforge' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'username, password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: puppetforge
          username:
            secure: secure
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'puppetforge', username: { secure: 'secure' }, password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'missing username', defaults: true do
    yaml %(
      deploy:
        provider: puppetforge
        password: str
    )
    it { should serialize_to **defaults, deploy: [provider: 'puppetforge', password: 'str'] }
    it { should have_msg [:error, :deploy, :required, key: 'username', provider: 'puppetforge'] }
    it { should_not have_msg [:error, :deploy, :required, key: 'password', provider: 'puppetforge'] }
  end

  describe 'missing password', defaults: true do
    yaml %(
      deploy:
        provider: puppetforge
        username: str
    )
    it { should serialize_to **defaults, deploy: [provider: 'puppetforge', username: 'str'] }
    it { should_not have_msg [:error, :deploy, :required, key: 'username', provider: 'puppetforge'] }
    it { should have_msg [:error, :deploy, :required, key: 'password', provider: 'puppetforge'] }
  end

  describe 'url' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: puppetforge
          username: str
          password: str
          url: str
      )
      it { should serialize_to deploy: [provider: 'puppetforge', username: 'str', password: 'str', url: 'str'] }
      it { should_not have_msg [:alert, :'deploy.username', :secure, type: :str] }
      it { should have_msg [:alert, :'deploy.password', :secure, type: :str] }
    end
  end
end

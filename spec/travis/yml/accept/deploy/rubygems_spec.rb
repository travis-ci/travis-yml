describe Travis::Yml, 'rubygems', alert: true do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'username' do
    describe 'given a map with secures' do
      yaml %(
        deploy:
          provider: rubygems
          username:
            production:
              secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'rubygems', username: { production: { secure: secure } }] }
      it { should_not have_msg }
    end

    describe 'given a map with strs' do
      yaml %(
        deploy:
          provider: rubygems
          username:
            production: str
      )
      it { should serialize_to deploy: [provider: 'rubygems', username: { production: 'str' }] }
      it { should_not have_msg [:alert, :'deploy.username', :secure, type: :str] }
    end

    describe 'given a secure' do
      yaml %(
        deploy:
          provider: rubygems
          username:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'rubygems', username: { secure: secure }] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: rubygems
          username: str
      )
      it { should serialize_to deploy: [provider: 'rubygems', username: 'str'] }
      it { should_not have_msg [:alert, :'deploy.username', :secure, type: :str] }
    end

    describe 'given a secure on alias user' do
      yaml %(
        deploy:
          provider: rubygems
          user:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'rubygems', username: { secure: secure }] }
      it { should have_msg [:info, :deploy, :alias_key, alias: 'user', key: 'username', provider: 'rubygems'] }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: rubygems
          api_key:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'rubygems', api_key: { secure: secure }] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: rubygems
          api_key: str
      )
      it { should serialize_to deploy: [provider: 'rubygems', api_key: 'str'] }
      it { should have_msg [:alert, :'deploy.api_key', :secure, type: :str] }
    end
  end

  describe 'gem' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: rubygems
          gem: str
      )
      it { should serialize_to deploy: [provider: 'rubygems', gem: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'gemspec' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: rubygems
          gemspec: str
      )
      it { should serialize_to deploy: [provider: 'rubygems', gemspec: 'str'] }
      it { should_not have_msg }
    end
  end
end

# +++ b/lib/travis/yml/schema/def/deploy/rubygems.rb
# +              # TODO strict does not end up on the secure
# +              map :username,     to: :map, type: :secure, strict: false
# +              map :host,         to: :str
#

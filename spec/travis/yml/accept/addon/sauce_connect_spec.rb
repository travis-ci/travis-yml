describe Travis::Yml, 'addon: sauce_connect' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given true' do
    yaml %(
      addons:
        sauce_connect: true
    )
    it { should serialize_to addons: { sauce_connect: { enabled: true } } }
  end

  describe 'username' do
    describe 'given a str' do
      yaml %(
        addons:
          sauce_connect:
            username: username
      )
      it { should serialize_to addons: { sauce_connect: { username: 'username' } } }
      it { should_not have_msg }
    end

    describe 'given a secure' do
      yaml %(
        addons:
          sauce_connect:
            username:
              secure: secure
      )
      it { should serialize_to addons: { sauce_connect: { username: { secure: 'secure' } } } }
      it { should_not have_msg }
    end
  end

  describe 'access_key' do
    describe 'given a str' do
      yaml %(
        addons:
          sauce_connect:
            access_key: access_key
      )
      it { should serialize_to addons: { sauce_connect: { access_key: 'access_key' } } }
      it { should_not have_msg }
    end

    describe 'given a secure' do
      yaml %(
        addons:
          sauce_connect:
            access_key:
              secure: secure
      )
      it { should serialize_to addons: { sauce_connect: { access_key: { secure: 'secure' } } } }
      it { should_not have_msg }
    end
  end

  describe 'direct_domains' do
    yaml %(
      addons:
        sauce_connect:
          direct_domains: str
    )
    it { should serialize_to addons: { sauce_connect: { direct_domains: 'str' } } }
    it { should_not have_msg }
  end

  describe 'tunnel_domains' do
    yaml %(
      addons:
        sauce_connect:
          tunnel_domains: str
    )
    it { should serialize_to addons: { sauce_connect: { tunnel_domains: 'str' } } }
    it { should_not have_msg }
  end

  describe 'no_ssl_bump_domains' do
    yaml %(
      addons:
        sauce_connect:
          no_ssl_bump_domains: str
    )
    it { should serialize_to addons: { sauce_connect: { no_ssl_bump_domains: 'str' } } }
    it { should_not have_msg }
  end

  describe 'given a nested, misplaced hash', v2: true, migrate: true do
    yaml %(
      addons:
        sauce_connect:
          sauce_connect: true
    )
    it { should serialize_to addons: { sauce_connect: { enabled: true } } }
    it { should have_msg [:warn, :'addons.sauce_connect', :migrate, key: :sauce_connect, to: :addons, value: true] }
  end
end

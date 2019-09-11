describe Travis::Yml, 'gleis' do
  subject { described_class.apply(parse(yaml)) }

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gleis
          app: str
      )
      it { should serialize_to deploy: [provider: 'gleis', app: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'username' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gleis
          username: str
      )
      it { should serialize_to deploy: [provider: 'gleis', username: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: gleis
          password:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'gleis', password: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'key_name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: gleis
          key_name: str
      )
      it { should serialize_to deploy: [provider: 'gleis', key_name: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'verbose' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: gleis
          verbose: true
      )
      it { should serialize_to deploy: [provider: 'gleis', verbose: true] }
      it { should_not have_msg }
    end
  end
end

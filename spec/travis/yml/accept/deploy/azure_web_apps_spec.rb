describe Travis::Yml, 'azure_web_apps' do
  subject { described_class.load(yaml) }

  describe 'site' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: azure_web_apps
          site: str
      )
      it { should serialize_to deploy: [provider: 'azure_web_apps', site: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'slot' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: azure_web_apps
          slot: str
      )
      it { should serialize_to deploy: [provider: 'azure_web_apps', slot: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'username' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: azure_web_apps
          username:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'azure_web_apps', username: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'password' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: azure_web_apps
          password:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'azure_web_apps', password: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'verbose' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: azure_web_apps
          verbose: true
      )
      it { should serialize_to deploy: [provider: 'azure_web_apps', verbose: true] }
      it { should_not have_msg }
    end
  end
end

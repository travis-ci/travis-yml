describe Travis::Yml, 'testfairy' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'selects' do
    yaml %(
      deploy:
        provider: testfairy
        api-key: str
        app-file: str
    )
      it { should serialize_to deploy: [provider: 'testfairy', 'api_key': 'str', 'app_file': 'str'] }
      # it { should_not have_msg }
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: testfairy
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'testfairy', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'app_file' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          app_file: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', app_file: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'symbols_file' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          symbols_file: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', symbols_file: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'testers_groups' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          testers_groups: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', testers_groups: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'notify' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: testfairy
          notify: true
      )
      it { should serialize_to deploy: [provider: 'testfairy', notify: true] }
      it { should_not have_msg }
    end
  end

  describe 'auto_update' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: testfairy
          auto_update: true
      )
      it { should serialize_to deploy: [provider: 'testfairy', auto_update: true] }
      it { should_not have_msg }
    end
  end

  describe 'advanced_options' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          advanced_options: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', advanced_options: 'str'] }
      it { should_not have_msg }
    end
  end
end

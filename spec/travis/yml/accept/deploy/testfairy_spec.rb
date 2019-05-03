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

  describe 'video_quality' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          video_quality: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', video_quality: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'screenshot_quality' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          screenshot_quality: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', screenshot_quality: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'screenshot_interval' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          screenshot_interval: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', screenshot_interval: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'max_duration' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          max_duration: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', max_duration: 'str'] }
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

  describe 'data_only_wifi' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: testfairy
          data_only_wifi: true
      )
      it { should serialize_to deploy: [provider: 'testfairy', data_only_wifi: true] }
      it { should_not have_msg }
    end
  end

  describe 'record_on_backgroup' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: testfairy
          record_on_background: true
      )
      it { should serialize_to deploy: [provider: 'testfairy', record_on_background: true] }
      it { should_not have_msg }
    end
  end

  describe 'video' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: testfairy
          video: true
      )
      it { should serialize_to deploy: [provider: 'testfairy', video: true] }
      it { should_not have_msg }
    end
  end

  describe 'icon_watermark' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: testfairy
          icon_watermark: true
      )
      it { should serialize_to deploy: [provider: 'testfairy', icon_watermark: true] }
      it { should_not have_msg }
    end
  end

  describe 'metrics' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: testfairy
          metrics: str
      )
      it { should serialize_to deploy: [provider: 'testfairy', metrics: 'str'] }
      it { should_not have_msg }
    end
  end
end

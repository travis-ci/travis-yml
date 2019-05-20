describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:testfairy]) }

  describe 'testfairy' do
    describe 'api_key' do
      it { should validate deploy: { provider: :testfairy, api_key: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, api_key: 1 } }
      it { should_not validate deploy: { provider: :testfairy, api_key: true } }
      it { should_not validate deploy: { provider: :testfairy, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, api_key: [{:foo=>'foo'}] } }
    end

    describe 'app_file' do
      it { should validate deploy: { provider: :testfairy, app_file: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, app_file: 1 } }
      it { should_not validate deploy: { provider: :testfairy, app_file: true } }
      it { should_not validate deploy: { provider: :testfairy, app_file: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, app_file: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, app_file: [{:foo=>'foo'}] } }
    end

    describe 'symbols_file' do
      it { should validate deploy: { provider: :testfairy, symbols_file: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, symbols_file: 1 } }
      it { should_not validate deploy: { provider: :testfairy, symbols_file: true } }
      it { should_not validate deploy: { provider: :testfairy, symbols_file: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, symbols_file: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, symbols_file: [{:foo=>'foo'}] } }
    end

    describe 'testers_groups' do
      it { should validate deploy: { provider: :testfairy, testers_groups: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, testers_groups: 1 } }
      it { should_not validate deploy: { provider: :testfairy, testers_groups: true } }
      it { should_not validate deploy: { provider: :testfairy, testers_groups: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, testers_groups: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, testers_groups: [{:foo=>'foo'}] } }
    end

    describe 'notify' do
      it { should validate deploy: { provider: :testfairy, notify: true } }
      it { should_not validate deploy: { provider: :testfairy, notify: 1 } }
      it { should_not validate deploy: { provider: :testfairy, notify: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, notify: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, notify: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, notify: [{:foo=>'foo'}] } }
    end

    describe 'auto_update' do
      it { should validate deploy: { provider: :testfairy, auto_update: true } }
      it { should_not validate deploy: { provider: :testfairy, auto_update: 1 } }
      it { should_not validate deploy: { provider: :testfairy, auto_update: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, auto_update: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, auto_update: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, auto_update: [{:foo=>'foo'}] } }
    end

    describe 'video_quality' do
      it { should validate deploy: { provider: :testfairy, video_quality: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, video_quality: 1 } }
      it { should_not validate deploy: { provider: :testfairy, video_quality: true } }
      it { should_not validate deploy: { provider: :testfairy, video_quality: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, video_quality: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, video_quality: [{:foo=>'foo'}] } }
    end

    describe 'screenshot_quality' do
      it { should validate deploy: { provider: :testfairy, screenshot_quality: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_quality: 1 } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_quality: true } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_quality: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_quality: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_quality: [{:foo=>'foo'}] } }
    end

    describe 'screenshot_interval' do
      it { should validate deploy: { provider: :testfairy, screenshot_interval: 1 } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_interval: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_interval: true } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_interval: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_interval: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, screenshot_interval: [{:foo=>'foo'}] } }
    end

    describe 'max_duration' do
      it { should validate deploy: { provider: :testfairy, max_duration: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, max_duration: 1 } }
      it { should_not validate deploy: { provider: :testfairy, max_duration: true } }
      it { should_not validate deploy: { provider: :testfairy, max_duration: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, max_duration: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, max_duration: [{:foo=>'foo'}] } }
    end

    describe 'advanced_options' do
      it { should validate deploy: { provider: :testfairy, advanced_options: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, advanced_options: 1 } }
      it { should_not validate deploy: { provider: :testfairy, advanced_options: true } }
      it { should_not validate deploy: { provider: :testfairy, advanced_options: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, advanced_options: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, advanced_options: [{:foo=>'foo'}] } }
    end

    describe 'data_only_wifi' do
      it { should validate deploy: { provider: :testfairy, data_only_wifi: true } }
      it { should_not validate deploy: { provider: :testfairy, data_only_wifi: 1 } }
      it { should_not validate deploy: { provider: :testfairy, data_only_wifi: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, data_only_wifi: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, data_only_wifi: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, data_only_wifi: [{:foo=>'foo'}] } }
    end

    describe 'record_on_backgroup' do
      it { should validate deploy: { provider: :testfairy, record_on_backgroup: true } }
      it { should_not validate deploy: { provider: :testfairy, record_on_backgroup: 1 } }
      it { should_not validate deploy: { provider: :testfairy, record_on_backgroup: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, record_on_backgroup: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, record_on_backgroup: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, record_on_backgroup: [{:foo=>'foo'}] } }
    end

    describe 'video' do
      it { should validate deploy: { provider: :testfairy, video: true } }
      it { should_not validate deploy: { provider: :testfairy, video: 1 } }
      it { should_not validate deploy: { provider: :testfairy, video: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, video: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, video: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, video: [{:foo=>'foo'}] } }
    end

    describe 'icon_watermark' do
      it { should validate deploy: { provider: :testfairy, icon_watermark: true } }
      it { should_not validate deploy: { provider: :testfairy, icon_watermark: 1 } }
      it { should_not validate deploy: { provider: :testfairy, icon_watermark: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, icon_watermark: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, icon_watermark: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, icon_watermark: [{:foo=>'foo'}] } }
    end

    describe 'metrics' do
      it { should validate deploy: { provider: :testfairy, metrics: 'str' } }
      it { should_not validate deploy: { provider: :testfairy, metrics: 1 } }
      it { should_not validate deploy: { provider: :testfairy, metrics: true } }
      it { should_not validate deploy: { provider: :testfairy, metrics: ['str'] } }
      it { should_not validate deploy: { provider: :testfairy, metrics: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :testfairy, metrics: [{:foo=>'foo'}] } }
    end
  end
end

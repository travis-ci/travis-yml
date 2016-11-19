describe Travis::Yaml, 'deploy testfairy' do
  let(:deploy) { subject.serialize[:deploy] }

  subject { described_class.apply(input) }

  let(:input) do
    {
      deploy: {
        provider: 'testfairy',
        api_key: api_key,
        app_file: 'app_file',
        symbols_file: 'symbols_file',
        keystore_file: 'keystore_file',
        storepass: 'storepass',
        alias: 'alias',
        testers_groups: 'testers_groups',
        notify: true,
        auto_update: true,
        video_quality: 'video_quality',
        screenshot_quality: 'screenshot_quality',
        screenshot_interval: '0',
        max_duration: 'max_duration',
        advanced_options: 'advanced_options',
        data_only_wifi: true,
        record_on_backgroup: true,
        video: true,
        icon_watermark: true,
        metrics: 'metrics',
      }
    }
  end

  describe 'api_key given as a string' do
    let(:api_key) { 'api_key' }
    it { expect(deploy).to eq [input[:deploy]] }
  end

  describe 'api_key given as a secure string' do
    let(:api_key) { { secure: 'secure' } }
    it { expect(deploy).to eq [input[:deploy]] }
  end
end

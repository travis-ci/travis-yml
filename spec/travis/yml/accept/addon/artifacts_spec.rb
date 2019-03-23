describe Travis::Yml, 'addon: artifacts' do
  let(:namespace) { %i(addons artifacts) }

  subject { described_class.apply(parse(yaml)) }

  describe 'given true' do
    yaml %(
      addons:
        artifacts: true
    )
    it { should serialize_to addons: { artifacts: { enabled: true } } }
  end

  describe 'bucket' do
    yaml %(
      addons:
        artifacts:
          bucket: bucket
    )
    it { should serialize_to addons: { artifacts: { bucket: 'bucket' } } }
    it { should_not have_msg }
  end

  describe 'key' do
    yaml %(
      addons:
        artifacts:
          key: key
    )
    it { should serialize_to addons: { artifacts: { key: 'key' } } }
    it { should_not have_msg }
  end

  describe 'secret' do
    yaml %(
      addons:
        artifacts:
          secret: secret
    )
    it { should serialize_to addons: { artifacts: { secret: 'secret' } } }
    it { should_not have_msg }
  end

  describe 'paths' do
    describe 'given a str' do
      yaml %(
        addons:
          artifacts:
            paths: ./path
      )
      it { should serialize_to addons: { artifacts: { paths: ['./path'] } } }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      yaml %(
        addons:
          artifacts:
            paths:
            - ./one
            - ./two
      )
      it { should serialize_to addons: { artifacts: { paths: ['./one', './two'] } } }
      it { should_not have_msg }
    end
  end

  describe 'branch' do
    yaml %(
      addons:
        artifacts:
          branch: branch
    )
    it { should serialize_to addons: { artifacts: { branch: 'branch' } } }
    it { should_not have_msg }
  end

  describe 'log_format' do
    yaml %(
      addons:
        artifacts:
          log_format: log_format
    )
    it { should serialize_to addons: { artifacts: { log_format: 'log_format' } } }
    it { should_not have_msg }
  end

  describe 'target_paths' do
    describe 'given a str' do
      yaml %(
        addons:
          artifacts:
            target_paths: target_paths
      )
      it { should serialize_to addons: { artifacts: { target_paths: ['target_paths'] } } }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      yaml %(
        addons:
          artifacts:
            target_paths:
            - one
            - two
      )
      it { should serialize_to addons: { artifacts: { target_paths: ['one', 'two'] } } }
      it { should_not have_msg }
    end
  end

  describe 'debug' do
    yaml %(
      addons:
        artifacts:
          debug: true
    )
    it { should serialize_to addons: { artifacts: { debug: true } } }
    it { should_not have_msg }
  end

  describe 'concurrency' do
    yaml %(
      addons:
        artifacts:
          concurrency: 40
    )
    it { should serialize_to addons: { artifacts: { concurrency: 40 } } }
    it { should_not have_msg }
  end

  describe 'max_size' do
    yaml %(
      addons:
        artifacts:
          max_size: 1024
    )
    it { should serialize_to addons: { artifacts: { max_size: 1024 } } }
    it { should_not have_msg }
  end

  describe 'given true, and a misplaced key', v2: true, migrate: true do
    let(:input) { { addons: { artifacts: true, region: 'us-west-2' } } }
    it { expect(artifacts).to eq enabled: true, region: 'us-west-2' }
  end

  describe 'given true, and a misplaced, alias key', v2: true, migrate: true do
    let(:input) { { addons: { artifacts: true, s3_region: 'us-west-2' } } }
    it { expect(artifacts).to eq enabled: true, region: 'us-west-2' }
  end
end

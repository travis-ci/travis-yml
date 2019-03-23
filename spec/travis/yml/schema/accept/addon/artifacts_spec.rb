require 'json'

describe Travis::Yml::Schema, 'accept', slow: true do
  subject { described_class.schema }

  describe 'artifacts' do
    describe 'enabled' do
      it { should validate addons: { artifacts: { enabled: true } } }

      it { should_not validate addons: { artifacts: { enabled: 'str' } } }
      it { should_not validate addons: { artifacts: { enabled: ['str'] } } }
      it { should_not validate addons: { artifacts: { enabled: 1 } } }
      it { should_not validate addons: { artifacts: { enabled: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { enabled: [ name: 'str' ] } } }
    end

    describe 'bucket' do
      it { should validate addons: { artifacts: { bucket: 'str' } } }

      it { should_not validate addons: { artifacts: { bucket: 1 } } }
      it { should_not validate addons: { artifacts: { bucket: true } } }
      it { should_not validate addons: { artifacts: { bucket: ['str'] } } }
      it { should_not validate addons: { artifacts: { bucket: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { bucket: [ name: 'str' ] } } }
    end

    describe 'endpoint' do
      it { should validate addons: { artifacts: { endpoint: 'str' } } }

      it { should_not validate addons: { artifacts: { endpoint: 1 } } }
      it { should_not validate addons: { artifacts: { endpoint: true } } }
      it { should_not validate addons: { artifacts: { endpoint: ['str'] } } }
      it { should_not validate addons: { artifacts: { endpoint: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { endpoint: [ name: 'str' ] } } }
    end

    describe 'key' do
      it { should validate addons: { artifacts: { key: 'str' } } }

      it { should_not validate addons: { artifacts: { key: 1 } } }
      it { should_not validate addons: { artifacts: { key: true } } }
      it { should_not validate addons: { artifacts: { key: ['str'] } } }
      it { should_not validate addons: { artifacts: { key: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { key: [ name: 'str' ] } } }
    end

    describe 'secret' do
      it { should validate addons: { artifacts: { secret: 'str' } } }

      it { should_not validate addons: { artifacts: { secret: 1 } } }
      it { should_not validate addons: { artifacts: { secret: true } } }
      it { should_not validate addons: { artifacts: { secret: ['str'] } } }
      it { should_not validate addons: { artifacts: { secret: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { secret: [ name: 'str' ] } } }
    end

    describe 'paths' do
      it { should validate addons: { artifacts: { paths: 'str' } } }
      it { should validate addons: { artifacts: { paths: ['str'] } } }

      it { should_not validate addons: { artifacts: { paths: 1 } } }
      it { should_not validate addons: { artifacts: { paths: true } } }
      it { should_not validate addons: { artifacts: { paths: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { paths: [ name: 'str' ] } } }
    end

    describe 'log_format' do
      it { should validate addons: { artifacts: { log_format: 'str' } } }

      it { should_not validate addons: { artifacts: { log_format: 1 } } }
      it { should_not validate addons: { artifacts: { log_format: true } } }
      it { should_not validate addons: { artifacts: { log_format: ['str'] } } }
      it { should_not validate addons: { artifacts: { log_format: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { log_format: [ name: 'str' ] } } }
    end

    describe 'target_paths' do
      it { should validate addons: { artifacts: { target_paths: 'str' } } }
      it { should validate addons: { artifacts: { target_paths: ['str'] } } }

      it { should_not validate addons: { artifacts: { target_paths: 1 } } }
      it { should_not validate addons: { artifacts: { target_paths: true } } }
      it { should_not validate addons: { artifacts: { target_paths: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { target_paths: [ name: 'str' ] } } }
    end

    describe 'debug' do
      it { should validate addons: { artifacts: { debug: true } } }

      it { should_not validate addons: { artifacts: { debug: 1 } } }
      it { should_not validate addons: { artifacts: { debug: 'str' } } }
      it { should_not validate addons: { artifacts: { debug: ['str'] } } }
      it { should_not validate addons: { artifacts: { debug: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { debug: [ name: 'str' ] } } }
    end

    describe 'concurrency' do
      it { should validate addons: { artifacts: { concurrency: 'str' } } }

      it { should_not validate addons: { artifacts: { concurrency: 1 } } }
      it { should_not validate addons: { artifacts: { concurrency: true } } }
      it { should_not validate addons: { artifacts: { concurrency: ['str'] } } }
      it { should_not validate addons: { artifacts: { concurrency: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { concurrency: [ name: 'str' ] } } }
    end

    describe 'max_size' do
      it { should validate addons: { artifacts: { max_size: 'str' } } }

      it { should_not validate addons: { artifacts: { max_size: 1 } } }
      it { should_not validate addons: { artifacts: { max_size: true } } }
      it { should_not validate addons: { artifacts: { max_size: ['str'] } } }
      it { should_not validate addons: { artifacts: { max_size: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { max_size: [ name: 'str' ] } } }
    end

    describe 'region' do
      it { should validate addons: { artifacts: { region: 'str' } } }

      it { should_not validate addons: { artifacts: { region: 1 } } }
      it { should_not validate addons: { artifacts: { region: true } } }
      it { should_not validate addons: { artifacts: { region: ['str'] } } }
      it { should_not validate addons: { artifacts: { region: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { region: [ name: 'str' ] } } }
    end

    describe 'permissions' do
      it { should validate addons: { artifacts: { permissions: 'str' } } }

      it { should_not validate addons: { artifacts: { permissions: 1 } } }
      it { should_not validate addons: { artifacts: { permissions: true } } }
      it { should_not validate addons: { artifacts: { permissions: ['str'] } } }
      it { should_not validate addons: { artifacts: { permissions: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { permissions: [ name: 'str' ] } } }
    end

    describe 'working_dir' do
      it { should validate addons: { artifacts: { working_dir: 'str' } } }

      it { should_not validate addons: { artifacts: { working_dir: 1 } } }
      it { should_not validate addons: { artifacts: { working_dir: true } } }
      it { should_not validate addons: { artifacts: { working_dir: ['str'] } } }
      it { should_not validate addons: { artifacts: { working_dir: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { working_dir: [ name: 'str' ] } } }
    end

    describe 'cache_control' do
      it { should validate addons: { artifacts: { cache_control: 'str' } } }

      it { should_not validate addons: { artifacts: { cache_control: 1 } } }
      it { should_not validate addons: { artifacts: { cache_control: true } } }
      it { should_not validate addons: { artifacts: { cache_control: ['str'] } } }
      it { should_not validate addons: { artifacts: { cache_control: { name: 'str' } } } }
      it { should_not validate addons: { artifacts: { cache_control: [ name: 'str' ] } } }
    end
  end
end

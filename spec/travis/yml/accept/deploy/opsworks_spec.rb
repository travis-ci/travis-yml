describe Travis::Yml, 'opsworks' do
  subject { described_class.load(yaml) }

  describe 'access_key_id' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: opsworks
          access_key_id:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'opsworks', access_key_id: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'secret_access_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: opsworks
          secret_access_key:
            secure: #{secure}
      )
      it { should serialize_to deploy: [provider: 'opsworks', secret_access_key: { secure: secure }] }
      it { should_not have_msg }
    end
  end

  describe 'app_id' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: opsworks
          app_id: str
      )
      it { should serialize_to deploy: [provider: 'opsworks', app_id: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'instance_ids' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: opsworks
          instance_ids: str
      )
      it { should serialize_to deploy: [provider: 'opsworks', instance_ids: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'layer_ids' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: opsworks
          layer_ids: str
      )
      it { should serialize_to deploy: [provider: 'opsworks', layer_ids: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'migrate' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: opsworks
          migrate: true
      )
      it { should serialize_to deploy: [provider: 'opsworks', migrate: true] }
      it { should_not have_msg }
    end
  end

  describe 'wait_until_deployed' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: opsworks
          wait_until_deployed: true
      )
      it { should serialize_to deploy: [provider: 'opsworks', wait_until_deployed: true] }
      it { should_not have_msg }
    end
  end

  describe 'custom_json' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: opsworks
          custom_json: str
      )
      it { should serialize_to deploy: [provider: 'opsworks', custom_json: 'str'] }
      it { should_not have_msg }
    end
  end
end

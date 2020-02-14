describe Travis::Yml, 'cloudformation' do
  subject { described_class.load(yaml) }

  describe 'access_key_id' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cloudformation
          access_key_id:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'cloudformation', access_key_id: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'secret_access_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: cloudformation
          secret_access_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'cloudformation', secret_access_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'region' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudformation
          region: str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', region: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'template' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudformation
          template: str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', template: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'stack_name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudformation
          stack_name: str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', stack_name: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'stack_name_prefix' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudformation
          stack_name_prefix: str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', stack_name_prefix: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'promote' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: cloudformation
          promote: true
      )
      it { should serialize_to deploy: [provider: 'cloudformation', promote: true] }
      it { should_not have_msg }
    end
  end

  describe 'role_arn' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudformation
          role_arn: str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', role_arn: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'sts_assume_role' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudformation
          sts_assume_role: str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', sts_assume_role: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'capabilities' do
    describe 'given strs' do
      yaml %(
        deploy:
          provider: cloudformation
          capabilities:
          - str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', capabilities: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'wait' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: cloudformation
          wait: true
      )
      it { should serialize_to deploy: [provider: 'cloudformation', wait: true] }
      it { should_not have_msg }
    end
  end

  describe 'wait_timeout' do
    describe 'given a num' do
      yaml %(
        deploy:
          provider: cloudformation
          wait_timeout: 1
      )
      it { should serialize_to deploy: [provider: 'cloudformation', wait_timeout: 1] }
      it { should_not have_msg }
    end
  end

  describe 'create_timeout' do
    describe 'given a num' do
      yaml %(
        deploy:
          provider: cloudformation
          create_timeout: 1
      )
      it { should serialize_to deploy: [provider: 'cloudformation', create_timeout: 1] }
      it { should_not have_msg }
    end
  end

  describe 'session_token' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudformation
          session_token: str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', session_token: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'parameters' do
    describe 'given strs' do
      yaml %(
        deploy:
          provider: cloudformation
          parameters:
          - str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', parameters: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'output_file' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: cloudformation
          output_file: str
      )
      it { should serialize_to deploy: [provider: 'cloudformation', output_file: 'str'] }
      it { should_not have_msg }
    end
  end
end

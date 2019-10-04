describe Travis::Yml, 'lambda' do
  subject { described_class.apply(parse(yaml)) }

  describe 'access_key_id' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: lambda
          access_key_id:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'lambda', access_key_id: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'secret_access_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: lambda
          secret_access_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'lambda', secret_access_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'region' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          region: str
      )
      it { should serialize_to deploy: [provider: 'lambda', region: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'function_name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          function_name: str
      )
      it { should serialize_to deploy: [provider: 'lambda', function_name: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'role' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          role: str
      )
      it { should serialize_to deploy: [provider: 'lambda', role: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'handler_name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          handler_name: str
      )
      it { should serialize_to deploy: [provider: 'lambda', handler_name: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'module_name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          module_name: str
      )
      it { should serialize_to deploy: [provider: 'lambda', module_name: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'zip' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          zip: str
      )
      it { should serialize_to deploy: [provider: 'lambda', zip: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'description' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          description: str
      )
      it { should serialize_to deploy: [provider: 'lambda', description: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'timeout' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          timeout: str
      )
      it { should serialize_to deploy: [provider: 'lambda', timeout: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'memory_size' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          memory_size: str
      )
      it { should serialize_to deploy: [provider: 'lambda', memory_size: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'runtime' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          runtime: str
      )
      it { should serialize_to deploy: [provider: 'lambda', runtime: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'environment' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          environment: str
      )
      it { should serialize_to deploy: [provider: 'lambda', environment: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'environment_variables (alias)' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          environment_variables: str
      )
      it { should serialize_to deploy: [provider: 'lambda', environment: ['str']] }
      it { should have_msg [:info, :deploy, :alias_key, alias: 'environment_variables', key: 'environment', provider: 'lambda'] }
    end
  end

  describe 'security_group_ids' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: lambda
          security_group_ids:
          - str
      )
      it { should serialize_to deploy: [provider: 'lambda', security_group_ids: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          security_group_ids: str
      )
      it { should serialize_to deploy: [provider: 'lambda', security_group_ids: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'subnet_ids' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: lambda
          subnet_ids:
          - str
      )
      it { should serialize_to deploy: [provider: 'lambda', subnet_ids: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          subnet_ids: str
      )
      it { should serialize_to deploy: [provider: 'lambda', subnet_ids: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'dead_letter_arn' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          dead_letter_arn: str
      )
      it { should serialize_to deploy: [provider: 'lambda', dead_letter_arn: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'kms_key_arn' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          kms_key_arn: str
      )
      it { should serialize_to deploy: [provider: 'lambda', kms_key_arn: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'tracing_mode' do
    describe 'given a enum' do
      yaml %(
        deploy:
          provider: lambda
          tracing_mode: Active
      )
      it { should serialize_to deploy: [provider: 'lambda', tracing_mode: 'Active'] }
      it { should_not have_msg }
    end
  end

  describe 'publish' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: lambda
          publish: true
      )
      it { should serialize_to deploy: [provider: 'lambda', publish: true] }
      it { should_not have_msg }
    end
  end

  describe 'function_tags' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          function_tags: str
      )
      it { should serialize_to deploy: [provider: 'lambda', function_tags: ['str']] }
      it { should_not have_msg }
    end
  end

  describe 'dot_match' do
    describe 'given a bool' do
      yaml %(
        deploy:
          provider: lambda
          dot_match: true
      )
      it { should serialize_to deploy: [provider: 'lambda', dot_match: true] }
      it { should_not have_msg }
    end
  end

  describe 'dead_letter_arn' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: lambda
          dead_letter_arn: str
      )
      it { should serialize_to deploy: [provider: 'lambda', dead_letter_arn: 'str'] }
      it { should_not have_msg }
    end
  end
end

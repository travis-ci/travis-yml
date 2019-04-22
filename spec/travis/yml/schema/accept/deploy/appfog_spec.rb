describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:appfog]) }

  describe 'appfog' do
    describe 'user' do
      it { should validate deploy: { provider: :appfog, user: 'str' } }
      it { should_not validate deploy: { provider: :appfog, user: 1 } }
      it { should_not validate deploy: { provider: :appfog, user: true } }
      it { should_not validate deploy: { provider: :appfog, user: ['str'] } }
      it { should_not validate deploy: { provider: :appfog, user: { foo: 'str' } } }
      it { should_not validate deploy: { provider: :appfog, user: [foo: 'str'] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :appfog, password: 'str' } }
      it { should validate deploy: { provider: :appfog, password: { secure: 'str' } } }
      it { should validate deploy: { provider: :appfog, password: { foo: 'str' } } }
      it { should validate deploy: { provider: :appfog, password: { foo: { secure: 'str' } } } }
      it { should_not validate deploy: { provider: :appfog, password: 1 } }
      it { should_not validate deploy: { provider: :appfog, password: true } }
      it { should_not validate deploy: { provider: :appfog, password: ['str'] } }
      it { should_not validate deploy: { provider: :appfog, password: [foo: 'str'] } }
    end

    describe 'api_key' do
      it { should validate deploy: { provider: :appfog, api_key: 'str' } }
      it { should_not validate deploy: { provider: :appfog, api_key: 1 } }
      it { should_not validate deploy: { provider: :appfog, api_key: true } }
      it { should_not validate deploy: { provider: :appfog, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :appfog, api_key: { foo: 'str' } } }
      it { should_not validate deploy: { provider: :appfog, api_key: [foo: 'str'] } }
    end

    describe 'email' do
      it { should validate deploy: { provider: :appfog, email: 'str' } }
      it { should validate deploy: { provider: :appfog, email: { secure: 'str' } } }
      it { should validate deploy: { provider: :appfog, email: { foo: 'str' } } }
      it { should validate deploy: { provider: :appfog, email: { foo: { secure: 'str' } } } }
      it { should_not validate deploy: { provider: :appfog, email: 1 } }
      it { should_not validate deploy: { provider: :appfog, email: true } }
      it { should_not validate deploy: { provider: :appfog, email: ['str'] } }
      it { should_not validate deploy: { provider: :appfog, email: [foo: 'str'] } }
    end

    describe 'app' do
      it { should validate deploy: { provider: :appfog, app: 'str' } }
      it { should validate deploy: { provider: :appfog, app: { foo: 'str' } } }
      it { should_not validate deploy: { provider: :appfog, app: 1 } }
      it { should_not validate deploy: { provider: :appfog, app: true } }
      it { should_not validate deploy: { provider: :appfog, app: ['str'] } }
      it { should_not validate deploy: { provider: :appfog, app: [foo: 'str'] } }
    end

    describe 'address' do
      it { should validate deploy: { provider: :appfog, address: 'str' } }
      it { should validate deploy: { provider: :appfog, address: ['str'] } }
      it { should_not validate deploy: { provider: :appfog, address: 1 } }
      it { should_not validate deploy: { provider: :appfog, address: true } }
      it { should_not validate deploy: { provider: :appfog, address: { foo: 'str' } } }
      it { should_not validate deploy: { provider: :appfog, address: [foo: 'str'] } }
    end

    describe 'metadata' do
      it { should validate deploy: { provider: :appfog, metadata: 'str' } }
      it { should_not validate deploy: { provider: :appfog, metadata: 1 } }
      it { should_not validate deploy: { provider: :appfog, metadata: true } }
      it { should_not validate deploy: { provider: :appfog, metadata: ['str'] } }
      it { should_not validate deploy: { provider: :appfog, metadata: { foo: 'str' } } }
      it { should_not validate deploy: { provider: :appfog, metadata: [foo: 'str'] } }
    end

    describe 'after_deploy' do
      it { should validate deploy: { provider: :appfog, after_deploy: 'str' } }
      it { should validate deploy: { provider: :appfog, after_deploy: ['str'] } }
      it { should_not validate deploy: { provider: :appfog, after_deploy: 1 } }
      it { should_not validate deploy: { provider: :appfog, after_deploy: true } }
      it { should_not validate deploy: { provider: :appfog, after_deploy: { foo: 'str' } } }
      it { should_not validate deploy: { provider: :appfog, after_deploy: [foo: 'str'] } }
    end
  end
end

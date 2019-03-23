describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:bluemixcf]) }

  describe 'bluemixcf' do
    describe 'username' do
      it { should validate deploy: { provider: :bluemixcf, username: 'str' } }
      it { should_not validate deploy: { provider: :bluemixcf, username: 1 } }
      it { should_not validate deploy: { provider: :bluemixcf, username: true } }
      it { should_not validate deploy: { provider: :bluemixcf, username: ['str'] } }
      it { should_not validate deploy: { provider: :bluemixcf, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bluemixcf, username: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :bluemixcf, password: 'str' } }
      it { should_not validate deploy: { provider: :bluemixcf, password: 1 } }
      it { should_not validate deploy: { provider: :bluemixcf, password: true } }
      it { should_not validate deploy: { provider: :bluemixcf, password: ['str'] } }
      it { should_not validate deploy: { provider: :bluemixcf, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bluemixcf, password: [{:foo=>'foo'}] } }
    end

    describe 'organization' do
      it { should validate deploy: { provider: :bluemixcf, organization: 'str' } }
      it { should_not validate deploy: { provider: :bluemixcf, organization: 1 } }
      it { should_not validate deploy: { provider: :bluemixcf, organization: true } }
      it { should_not validate deploy: { provider: :bluemixcf, organization: ['str'] } }
      it { should_not validate deploy: { provider: :bluemixcf, organization: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bluemixcf, organization: [{:foo=>'foo'}] } }
    end

    describe 'api' do
      it { should validate deploy: { provider: :bluemixcf, api: 'str' } }
      it { should_not validate deploy: { provider: :bluemixcf, api: 1 } }
      it { should_not validate deploy: { provider: :bluemixcf, api: true } }
      it { should_not validate deploy: { provider: :bluemixcf, api: ['str'] } }
      it { should_not validate deploy: { provider: :bluemixcf, api: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bluemixcf, api: [{:foo=>'foo'}] } }
    end

    describe 'space' do
      it { should validate deploy: { provider: :bluemixcf, space: 'str' } }
      it { should_not validate deploy: { provider: :bluemixcf, space: 1 } }
      it { should_not validate deploy: { provider: :bluemixcf, space: true } }
      it { should_not validate deploy: { provider: :bluemixcf, space: ['str'] } }
      it { should_not validate deploy: { provider: :bluemixcf, space: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bluemixcf, space: [{:foo=>'foo'}] } }
    end

    describe 'region' do
      it { should validate deploy: { provider: :bluemixcf, region: 'str' } }
      it { should_not validate deploy: { provider: :bluemixcf, region: 1 } }
      it { should_not validate deploy: { provider: :bluemixcf, region: true } }
      it { should_not validate deploy: { provider: :bluemixcf, region: ['str'] } }
      it { should_not validate deploy: { provider: :bluemixcf, region: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bluemixcf, region: [{:foo=>'foo'}] } }
    end

    describe 'manifest' do
      it { should validate deploy: { provider: :bluemixcf, manifest: 'str' } }
      it { should_not validate deploy: { provider: :bluemixcf, manifest: 1 } }
      it { should_not validate deploy: { provider: :bluemixcf, manifest: true } }
      it { should_not validate deploy: { provider: :bluemixcf, manifest: ['str'] } }
      it { should_not validate deploy: { provider: :bluemixcf, manifest: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bluemixcf, manifest: [{:foo=>'foo'}] } }
    end

    describe 'skip_ssl_validation' do
      it { should validate deploy: { provider: :bluemixcf, skip_ssl_validation: true } }
      it { should_not validate deploy: { provider: :bluemixcf, skip_ssl_validation: 1 } }
      it { should_not validate deploy: { provider: :bluemixcf, skip_ssl_validation: 'str' } }
      it { should_not validate deploy: { provider: :bluemixcf, skip_ssl_validation: ['str'] } }
      it { should_not validate deploy: { provider: :bluemixcf, skip_ssl_validation: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :bluemixcf, skip_ssl_validation: [{:foo=>'foo'}] } }
    end
  end
end

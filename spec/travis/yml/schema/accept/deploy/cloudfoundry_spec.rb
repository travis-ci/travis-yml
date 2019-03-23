describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:cloudfoundry]) }

  describe 'cloudfoundry' do
    describe 'username' do
      it { should validate deploy: { provider: :cloudfoundry, username: 'str' } }
      it { should_not validate deploy: { provider: :cloudfoundry, username: 1 } }
      it { should_not validate deploy: { provider: :cloudfoundry, username: true } }
      it { should_not validate deploy: { provider: :cloudfoundry, username: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfoundry, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfoundry, username: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :cloudfoundry, password: 'str' } }
      it { should_not validate deploy: { provider: :cloudfoundry, password: 1 } }
      it { should_not validate deploy: { provider: :cloudfoundry, password: true } }
      it { should_not validate deploy: { provider: :cloudfoundry, password: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfoundry, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfoundry, password: [{:foo=>'foo'}] } }
    end

    describe 'organization' do
      it { should validate deploy: { provider: :cloudfoundry, organization: 'str' } }
      it { should_not validate deploy: { provider: :cloudfoundry, organization: 1 } }
      it { should_not validate deploy: { provider: :cloudfoundry, organization: true } }
      it { should_not validate deploy: { provider: :cloudfoundry, organization: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfoundry, organization: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfoundry, organization: [{:foo=>'foo'}] } }
    end

    describe 'api' do
      it { should validate deploy: { provider: :cloudfoundry, api: 'str' } }
      it { should_not validate deploy: { provider: :cloudfoundry, api: 1 } }
      it { should_not validate deploy: { provider: :cloudfoundry, api: true } }
      it { should_not validate deploy: { provider: :cloudfoundry, api: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfoundry, api: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfoundry, api: [{:foo=>'foo'}] } }
    end

    describe 'space' do
      it { should validate deploy: { provider: :cloudfoundry, space: 'str' } }
      it { should_not validate deploy: { provider: :cloudfoundry, space: 1 } }
      it { should_not validate deploy: { provider: :cloudfoundry, space: true } }
      it { should_not validate deploy: { provider: :cloudfoundry, space: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfoundry, space: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfoundry, space: [{:foo=>'foo'}] } }
    end

    describe 'key' do
      it { should validate deploy: { provider: :cloudfoundry, key: 'str' } }
      it { should_not validate deploy: { provider: :cloudfoundry, key: 1 } }
      it { should_not validate deploy: { provider: :cloudfoundry, key: true } }
      it { should_not validate deploy: { provider: :cloudfoundry, key: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfoundry, key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfoundry, key: [{:foo=>'foo'}] } }
    end

    describe 'manifest' do
      it { should validate deploy: { provider: :cloudfoundry, manifest: 'str' } }
      it { should_not validate deploy: { provider: :cloudfoundry, manifest: 1 } }
      it { should_not validate deploy: { provider: :cloudfoundry, manifest: true } }
      it { should_not validate deploy: { provider: :cloudfoundry, manifest: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfoundry, manifest: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfoundry, manifest: [{:foo=>'foo'}] } }
    end

    describe 'skip_ssl_validation' do
      it { should validate deploy: { provider: :cloudfoundry, skip_ssl_validation: true } }
      it { should_not validate deploy: { provider: :cloudfoundry, skip_ssl_validation: 1 } }
      it { should_not validate deploy: { provider: :cloudfoundry, skip_ssl_validation: 'str' } }
      it { should_not validate deploy: { provider: :cloudfoundry, skip_ssl_validation: ['str'] } }
      it { should_not validate deploy: { provider: :cloudfoundry, skip_ssl_validation: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudfoundry, skip_ssl_validation: [{:foo=>'foo'}] } }
    end
  end
end

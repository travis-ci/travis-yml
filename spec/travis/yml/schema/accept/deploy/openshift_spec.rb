describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:openshift]) }

  describe 'openshift' do
    describe 'user' do
      it { should validate deploy: { provider: :openshift, user: 'str' } }
      it { should_not validate deploy: { provider: :openshift, user: 1 } }
      it { should_not validate deploy: { provider: :openshift, user: true } }
      it { should_not validate deploy: { provider: :openshift, user: ['str'] } }
      it { should_not validate deploy: { provider: :openshift, user: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :openshift, user: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :openshift, password: 'str' } }
      it { should_not validate deploy: { provider: :openshift, password: 1 } }
      it { should_not validate deploy: { provider: :openshift, password: true } }
      it { should_not validate deploy: { provider: :openshift, password: ['str'] } }
      it { should_not validate deploy: { provider: :openshift, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :openshift, password: [{:foo=>'foo'}] } }
    end

    describe 'domain' do
      it { should validate deploy: { provider: :openshift, domain: 'str' } }
      it { should_not validate deploy: { provider: :openshift, domain: 1 } }
      it { should_not validate deploy: { provider: :openshift, domain: true } }
      it { should_not validate deploy: { provider: :openshift, domain: ['str'] } }
      it { should_not validate deploy: { provider: :openshift, domain: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :openshift, domain: [{:foo=>'foo'}] } }
    end

    describe 'app' do
      it { should validate deploy: { provider: :openshift, app: 'str' } }
      it { should_not validate deploy: { provider: :openshift, app: 1 } }
      it { should_not validate deploy: { provider: :openshift, app: true } }
      it { should_not validate deploy: { provider: :openshift, app: ['str'] } }
      it { should_not validate deploy: { provider: :openshift, app: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :openshift, app: [{:foo=>'foo'}] } }
    end

    describe 'deployment_branch' do
      it { should validate deploy: { provider: :openshift, deployment_branch: 'str' } }
      it { should_not validate deploy: { provider: :openshift, deployment_branch: 1 } }
      it { should_not validate deploy: { provider: :openshift, deployment_branch: true } }
      it { should_not validate deploy: { provider: :openshift, deployment_branch: ['str'] } }
      it { should_not validate deploy: { provider: :openshift, deployment_branch: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :openshift, deployment_branch: [{:foo=>'foo'}] } }
    end
  end
end

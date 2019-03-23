describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:cloudcontrol]) }

  describe 'cloudcontrol' do
    describe 'email' do
      it { should validate deploy: { provider: :cloudcontrol, email: 'str' } }
      it { should_not validate deploy: { provider: :cloudcontrol, email: 1 } }
      it { should_not validate deploy: { provider: :cloudcontrol, email: true } }
      it { should_not validate deploy: { provider: :cloudcontrol, email: ['str'] } }
      it { should_not validate deploy: { provider: :cloudcontrol, email: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudcontrol, email: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :cloudcontrol, password: 'str' } }
      it { should_not validate deploy: { provider: :cloudcontrol, password: 1 } }
      it { should_not validate deploy: { provider: :cloudcontrol, password: true } }
      it { should_not validate deploy: { provider: :cloudcontrol, password: ['str'] } }
      it { should_not validate deploy: { provider: :cloudcontrol, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudcontrol, password: [{:foo=>'foo'}] } }
    end

    describe 'deployment' do
      it { should validate deploy: { provider: :cloudcontrol, deployment: 'str' } }
      it { should_not validate deploy: { provider: :cloudcontrol, deployment: 1 } }
      it { should_not validate deploy: { provider: :cloudcontrol, deployment: true } }
      it { should_not validate deploy: { provider: :cloudcontrol, deployment: ['str'] } }
      it { should_not validate deploy: { provider: :cloudcontrol, deployment: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :cloudcontrol, deployment: [{:foo=>'foo'}] } }
    end
  end
end

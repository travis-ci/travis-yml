describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:firebase]) }

  describe 'firebase' do
    describe 'project' do
      it { should validate deploy: { provider: :firebase, project: 'str' } }
      it { should_not validate deploy: { provider: :firebase, project: 1 } }
      it { should_not validate deploy: { provider: :firebase, project: true } }
      it { should_not validate deploy: { provider: :firebase, project: ['str'] } }
      it { should_not validate deploy: { provider: :firebase, project: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :firebase, project: [{:foo=>'foo'}] } }
    end

    describe 'token' do
      it { should validate deploy: { provider: :firebase, token: 'str' } }
      it { should_not validate deploy: { provider: :firebase, token: 1 } }
      it { should_not validate deploy: { provider: :firebase, token: true } }
      it { should_not validate deploy: { provider: :firebase, token: ['str'] } }
      it { should_not validate deploy: { provider: :firebase, token: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :firebase, token: [{:foo=>'foo'}] } }
    end

    describe 'message' do
      it { should validate deploy: { provider: :firebase, message: 'str' } }
      it { should_not validate deploy: { provider: :firebase, message: 1 } }
      it { should_not validate deploy: { provider: :firebase, message: true } }
      it { should_not validate deploy: { provider: :firebase, message: ['str'] } }
      it { should_not validate deploy: { provider: :firebase, message: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :firebase, message: [{:foo=>'foo'}] } }
    end
  end
end

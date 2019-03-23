describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:hackage]) }

  describe 'hackage' do
    describe 'username' do
      it { should validate deploy: { provider: :hackage, username: 'str' } }
      it { should_not validate deploy: { provider: :hackage, username: 1 } }
      it { should_not validate deploy: { provider: :hackage, username: true } }
      it { should_not validate deploy: { provider: :hackage, username: ['str'] } }
      it { should_not validate deploy: { provider: :hackage, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :hackage, username: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :hackage, password: 'str' } }
      it { should_not validate deploy: { provider: :hackage, password: 1 } }
      it { should_not validate deploy: { provider: :hackage, password: true } }
      it { should_not validate deploy: { provider: :hackage, password: ['str'] } }
      it { should_not validate deploy: { provider: :hackage, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :hackage, password: [{:foo=>'foo'}] } }
    end
  end
end

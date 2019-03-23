describe Travis::Yml::Schema, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:anynines]) }

  describe 'anynines' do
    describe 'username' do
      it { should validate deploy: { provider: :anynines, username: 'str' } }
      it { should_not validate deploy: { provider: :anynines, username: 1 } }
      it { should_not validate deploy: { provider: :anynines, username: true } }
      it { should_not validate deploy: { provider: :anynines, username: ['str'] } }
      it { should_not validate deploy: { provider: :anynines, username: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :anynines, username: [{:foo=>'foo'}] } }
    end

    describe 'password' do
      it { should validate deploy: { provider: :anynines, password: 'str' } }
      it { should_not validate deploy: { provider: :anynines, password: 1 } }
      it { should_not validate deploy: { provider: :anynines, password: true } }
      it { should_not validate deploy: { provider: :anynines, password: ['str'] } }
      it { should_not validate deploy: { provider: :anynines, password: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :anynines, password: [{:foo=>'foo'}] } }
    end

    describe 'organization' do
      it { should validate deploy: { provider: :anynines, organization: 'str' } }
      it { should_not validate deploy: { provider: :anynines, organization: 1 } }
      it { should_not validate deploy: { provider: :anynines, organization: true } }
      it { should_not validate deploy: { provider: :anynines, organization: ['str'] } }
      it { should_not validate deploy: { provider: :anynines, organization: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :anynines, organization: [{:foo=>'foo'}] } }
    end

    describe 'space' do
      it { should validate deploy: { provider: :anynines, space: 'str' } }
      it { should_not validate deploy: { provider: :anynines, space: 1 } }
      it { should_not validate deploy: { provider: :anynines, space: true } }
      it { should_not validate deploy: { provider: :anynines, space: ['str'] } }
      it { should_not validate deploy: { provider: :anynines, space: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :anynines, space: [{:foo=>'foo'}] } }
    end
  end
end

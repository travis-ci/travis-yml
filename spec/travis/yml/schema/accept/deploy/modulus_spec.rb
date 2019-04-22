describe Travis::Yml, 'accept deploy', slow: true do
  subject { described_class.schema }

  xit { puts JSON.pretty_generate(subject[:definitions][:modulus]) }

  describe 'modulus' do
    describe 'api_key' do
      it { should validate deploy: { provider: :modulus, api_key: 'str' } }
      it { should_not validate deploy: { provider: :modulus, api_key: 1 } }
      it { should_not validate deploy: { provider: :modulus, api_key: true } }
      it { should_not validate deploy: { provider: :modulus, api_key: ['str'] } }
      it { should_not validate deploy: { provider: :modulus, api_key: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :modulus, api_key: [{:foo=>'foo'}] } }
    end

    describe 'project_name' do
      it { should validate deploy: { provider: :modulus, project_name: 'str' } }
      it { should_not validate deploy: { provider: :modulus, project_name: 1 } }
      it { should_not validate deploy: { provider: :modulus, project_name: true } }
      it { should_not validate deploy: { provider: :modulus, project_name: ['str'] } }
      it { should_not validate deploy: { provider: :modulus, project_name: {:foo=>'foo'} } }
      it { should_not validate deploy: { provider: :modulus, project_name: [{:foo=>'foo'}] } }
    end
  end
end

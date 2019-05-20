describe Travis::Yml, 'chef_supermarket' do
  subject { described_class.apply(parse(yaml)) }

  describe 'user_id' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: chef_supermarket
          user_id:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'chef_supermarket', user_id: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'client_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: chef_supermarket
          client_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'chef_supermarket', client_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'cookbook_category' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: chef_supermarket
          cookbook_category: str
      )
      it { should serialize_to deploy: [provider: 'chef_supermarket', cookbook_category: 'str'] }
      it { should_not have_msg }
    end
  end
end

describe Travis::Yml, 'modulus' do
  subject { described_class.apply(parse(yaml)) }

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: modulus
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'modulus', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'project_name' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: modulus
          project_name: str
      )
      it { should serialize_to deploy: [provider: 'modulus', project_name: 'str'] }
      it { should_not have_msg }
    end
  end
end

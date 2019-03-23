describe Travis::Yml, 'rubygems' do
  subject { described_class.apply(parse(yaml)) }

  describe 'gem' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: rubygems
          gem: str
      )
      it { should serialize_to deploy: [provider: 'rubygems', gem: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'file' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: rubygems
          file: str
      )
      it { should serialize_to deploy: [provider: 'rubygems', file: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'gemspec' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: rubygems
          gemspec: str
      )
      it { should serialize_to deploy: [provider: 'rubygems', gemspec: 'str'] }
      it { should_not have_msg }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: rubygems
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'rubygems', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end
end

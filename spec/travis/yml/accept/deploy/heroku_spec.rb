describe Travis::Yml, 'heroku' do
  subject { described_class.apply(parse(yaml)) }

  describe 'strategy' do
    describe 'given a enum' do
      yaml %(
        deploy:
          provider: heroku
          strategy: api
      )
      it { should serialize_to deploy: [provider: 'heroku', strategy: 'api'] }
      it { should_not have_msg }
    end
  end

  # describe 'buildpack' do
  #   describe 'given a str' do
  #     yaml %(
  #       deploy:
  #         provider: heroku
  #         buildpack: str
  #     )
  #     it { should serialize_to deploy: [provider: 'heroku', buildpack: 'str'] }
  #     it { should_not have_msg }
  #   end
  # end

  describe 'app' do
    describe 'given a str' do
      yaml %(
        deploy:
          provider: heroku
          app: str
      )
      it { should serialize_to deploy: [provider: 'heroku', app: 'str'] }
      it { should_not have_msg }
    end

    describe 'given a map' do
      yaml %(
        deploy:
          provider: heroku
          app:
            master: production
            staging: staging
      )
      it { should serialize_to deploy: [provider: 'heroku', app: { master: 'production', staging: 'staging' }] }
      it { should_not have_msg }
    end
  end

  describe 'api_key' do
    describe 'given a secure' do
      yaml %(
        deploy:
          provider: heroku
          api_key:
            secure: secure
      )
      it { should serialize_to deploy: [provider: 'heroku', api_key: { secure: 'secure' }] }
      it { should_not have_msg }
    end
  end

  describe 'run' do
    describe 'given a seq of strs' do
      yaml %(
        deploy:
          provider: heroku
          run:
          - str
      )
      it { should serialize_to deploy: [provider: 'heroku', run: ['str']] }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        deploy:
          provider: heroku
          run: str
      )
      it { should serialize_to deploy: [provider: 'heroku', run: ['str']] }
      it { should_not have_msg }
    end
  end
end

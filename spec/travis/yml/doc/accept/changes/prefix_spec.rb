describe Travis::Yml, 'prefix' do
  subject { described_class.apply(parse(yaml), opts) }

  describe 'deploy.on given a str' do
    yaml %(
      deploy:
        provider: script
        on: master
    )
    it { should serialize_to deploy: [{ provider: 'script', on: { branch: ['master'] } }] }
  end
end

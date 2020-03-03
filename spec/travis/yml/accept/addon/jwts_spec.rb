describe Travis::Yml, 'addon: jwts' do
  subject { described_class.load(yaml) }

  describe 'given a str' do
    yaml %(
      addons:
        jwt: foo
    )
    it { should serialize_to addons: { jwt: ['foo'] } }
    it { should have_msg [:warn, :addons, :deprecated_key, key: 'jwt', info: 'Discontinued as of April 17, 2018'] }
  end

  describe 'given a secure' do
    yaml %(
      addons:
        jwt:
          secure: foo
    )
    it { should serialize_to addons: { jwt: [secure: 'foo'] } }
  end

  describe 'given a seq of strs' do
    yaml %(
      addons:
        jwt:
        - foo
    )
    it { should serialize_to addons: { jwt: ['foo'] } }
  end

  describe 'given a seq of secures' do
    yaml %(
      addons:
        jwt:
        - secure: foo
    )
    it { should serialize_to addons: { jwt: [secure: 'foo'] } }
  end
end

describe Travis::Yml, 'addon: jwts' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given a str' do
    yaml %(
      addons:
        jwt: foo
    )
    it { should serialize_to addons: { jwt: ['foo'] } }
    it { should_not have_msg }
  end

  describe 'given a secure' do
    yaml %(
      addons:
        jwt:
          secure: foo
    )
    it { should serialize_to addons: { jwt: [secure: 'foo'] } }
    it { should_not have_msg }
  end

  describe 'given a seq of strs' do
    yaml %(
      addons:
        jwt:
        - foo
    )
    it { should serialize_to addons: { jwt: ['foo'] } }
    it { should_not have_msg }
  end

  describe 'given a seq of secures' do
    yaml %(
      addons:
        jwt:
        - secure: foo
    )
    it { should serialize_to addons: { jwt: [secure: 'foo'] } }
    it { should_not have_msg }
  end
end

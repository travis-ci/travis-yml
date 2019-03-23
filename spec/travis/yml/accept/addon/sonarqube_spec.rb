describe Travis::Yml, 'addon: sonarqube' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given true' do
    yaml %(
      addons:
        sonarqube: true
    )
    it { should serialize_to addons: { sonarqube: true } }
    it { should_not have_msg }
  end

  describe 'given a str' do
    yaml %(
      addons:
        sonarqube: str
    )
    it { should serialize_to empty }
    it { should have_msg [:error, :'addons.sonarqube', :invalid_type, expected: :map, actual: :str, value: 'str'] }
  end

  describe 'given a seq' do
    yaml %(
      addons:
        sonarqube:
        - str
    )
    it { should serialize_to empty }
    it { should have_msg [:error, :'addons.sonarqube', :invalid_type, expected: :map, actual: :seq, value: ['str']] }
  end

  describe 'given a map' do
    yaml %(
      addons:
        sonarqube:
          foo: str
    )
    it { should serialize_to addons: { sonarqube: { foo: 'str' } } }
    it { should_not have_msg }
  end
end

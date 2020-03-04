describe Travis::Yml, 'addon: pkg' do
  subject { described_class.apply(parse(yaml)) }

  describe 'packages given a string' do
    yaml %(
      addons:
        pkg:
          packages: str
    )
    it { should serialize_to addons: { pkg: { packages: ['str'] } } }
    it { should_not have_msg }
  end

  describe 'package given a string (alias)' do
    yaml %(
      addons:
        pkg:
          package: str
    )
    it { should serialize_to addons: { pkg: { packages: ['str'] } } }
    it { should have_msg [:info, :'addons.pkg', :alias_key, alias: 'package', key: 'packages'] }
  end

  describe 'packages given a seq' do
    yaml %(
      addons:
        pkg:
          packages:
          - str
    )
    it { should serialize_to addons: { pkg: { packages: ['str'] } } }
    it { should_not have_msg }
  end

  describe 'package given a seq (alias)' do
    yaml %(
      addons:
        pkg:
          package:
          - str
    )
    it { should serialize_to addons: { pkg: { packages: ['str'] } } }
    it { should have_msg [:info, :'addons.pkg', :alias_key, alias: 'package', key: 'packages'] }
  end

  describe 'branch given a string' do
    yaml %(
      addons:
        pkg:
          branch: str
    )
    it { should serialize_to addons: { pkg: { branch: 'str' } } }
    it { should_not have_msg }
  end
end

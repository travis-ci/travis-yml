describe Travis::Yml, 'addon: chrome' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given stable' do
    yaml %(
      addons:
        chrome: stable
    )
    it { should serialize_to addons: { chrome: 'stable' } }
    it { should_not have_msg }
  end

  describe 'given beta' do
    yaml %(
      addons:
        chrome: beta
    )
    it { should serialize_to addons: { chrome: 'beta' } }
    it { should_not have_msg }
  end

  describe 'given STABLE' do
    yaml %(
      addons:
        chrome: STABLE
    )
    it { should serialize_to addons: { chrome: 'stable' } }
    it { should have_msg [:info, :'addons.chrome', :downcase, value: 'STABLE'] }
  end

  describe 'given unknown' do
    yaml %(
      addons:
        chrome: unknown
    )
    it { should serialize_to addons: { chrome: 'unknown' } }
    it { should have_msg [:error, :'addons.chrome', :unknown_value, value: 'unknown'] }
  end
end

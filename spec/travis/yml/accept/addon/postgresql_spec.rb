describe Travis::Yml, 'addon: postgresql' do
  subject { described_class.apply(parse(yaml)) }

  describe 'postgresql' do
    yaml %(
      addons:
        postgresql: 9.1
    )
    it { should serialize_to addons: { postgresql: '9.1' } }
    it { should_not have_msg }
  end

  describe 'postgres (alias)' do
    yaml %(
      addons:
        postgres: 9.1
    )
    it { should serialize_to addons: { postgresql: '9.1' } }
    it { should have_msg [:info, :addons, :alias, type: :key, alias: 'postgres', obj: 'postgresql'] }
  end
end

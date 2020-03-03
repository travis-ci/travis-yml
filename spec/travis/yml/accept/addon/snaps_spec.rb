describe Travis::Yml, 'addon: snaps' do
  subject { described_class.load(yaml) }

  describe 'given a string' do
    yaml %(
      addons:
        snaps: str
    )
    it { should serialize_to addons: { snaps: [name: 'str'] } }
    it { should_not have_msg }
  end

  describe 'given a hash' do
    yaml %(
      addons:
        snaps:
          name: str
          classic: true
    )
    it { should serialize_to addons: { snaps: [name: 'str', classic: true] } }
    it { should_not have_msg }
  end

  describe 'given an array of strs' do
    yaml %(
      addons:
        snaps:
          - str
    )
    it { should serialize_to addons: { snaps: [name: 'str'] } }
    it { should_not have_msg }
  end

  describe 'given an array of strs and hashes' do
    yaml %(
      addons:
        snaps:
          - name: one
            classic: true
          - two
    )
    it { should serialize_to addons: { snaps: [{ name: 'one', classic: true }, { name: 'two' }] } }
    it { should_not have_msg }
  end
end

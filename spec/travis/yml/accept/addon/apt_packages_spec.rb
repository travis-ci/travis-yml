describe Travis::Yml do
  accept 'addon: apt_packages' do
    describe 'given a string' do
      yaml %(
        addons:
          apt_packages: curl
      )
      it { should serialize_to addons: { apt_packages: ['curl'] } }
      it { should_not have_msg }
    end

    describe 'given an array' do
      yaml %(
        addons:
          apt_packages:
          - curl
          - git
      )
      it { should serialize_to addons: { apt_packages: ['curl', 'git'] } }
      it { should_not have_msg }
    end
  end
end

describe Travis::Yml do
  accept 'addon: firefox' do
    describe 'given a num' do
      yaml %(
        addons:
          firefox: 47
      )
      it { should serialize_to addons: { firefox: '47' } }
      it { should_not have_msg }
    end

    describe 'given a str' do
      yaml %(
        addons:
          firefox: 47.0.1
      )
      it { should serialize_to addons: { firefox: '47.0.1' } }
      it { should_not have_msg }
    end

    describe 'given a str (quoted)' do
      yaml %(
        addons:
          firefox: "47.0.1"
      )
      it { should serialize_to addons: { firefox: '47.0.1' } }
      it { should_not have_msg }
    end
  end
end

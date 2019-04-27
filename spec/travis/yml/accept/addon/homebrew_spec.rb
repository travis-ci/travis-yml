describe Travis::Yml, 'addon: homebrew' do
  subject { described_class.apply(parse(yaml)) }

  describe 'given a string' do
    yaml %(
      addons:
        homebrew: str
    )
    it { should serialize_to addons: { homebrew: { packages: ['str'] } } }
    it { should_not have_msg }
  end

  describe 'packages' do
    describe 'given a string' do
      yaml %(
        addons:
          homebrew:
            packages: str
      )
      it { should serialize_to addons: { homebrew: { packages: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given an array' do
      yaml %(
        addons:
          homebrew:
            packages:
            - str
      )
      it { should serialize_to addons: { homebrew: { packages: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given a nested array (happens when using aliases)' do
      yaml %(
        addons:
          homebrew:
            packages:
            -
              - str
      )
      it { should serialize_to addons: { homebrew: { packages: ['str'] } } }
      it { should_not have_msg }
    end
  end

  describe 'casks' do
    let(:value) { { addons: { homebrew: { casks: casks } } } }

    describe 'given a string' do
      yaml %(
        addons:
          homebrew:
            casks: str
      )
      it { should serialize_to addons: { homebrew: { casks: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given an array' do
      yaml %(
        addons:
          homebrew:
            casks:
            - str
      )
      it { should serialize_to addons: { homebrew: { casks: ['str'] } } }
      it { should_not have_msg }
    end
  end

  describe 'taps' do
    let(:value) { { addons: { homebrew: { taps: taps } } } }

    describe 'given a string' do
      yaml %(
        addons:
          homebrew:
            taps: str
      )
      it { should serialize_to addons: { homebrew: { taps: ['str'] } } }
      it { should_not have_msg }
    end

    describe 'given an array' do
      yaml %(
        addons:
          homebrew:
            taps:
            - str
      )
      it { should serialize_to addons: { homebrew: { taps: ['str'] } } }
      it { should_not have_msg }
    end
  end

  describe 'update' do
    describe 'given a bool' do
      yaml %(
        addons:
          homebrew:
            update: true
      )
      it { should serialize_to addons: { homebrew: { update: true } } }
      it { should_not have_msg }
    end

    describe 'given a string' do
      yaml %(
        addons:
          homebrew:
            update: 'true'
      )
      it { should serialize_to addons: { homebrew: { update: true } } }
      it { should_not have_msg }
    end
  end

  describe 'brewfile' do
    describe 'given a string' do
      yaml %(
        addons:
          homebrew:
            brewfile: str
      )
      it { should serialize_to addons: { homebrew: { brewfile: 'str' } } }
      it { should_not have_msg }
    end

    describe 'given a seq' do
      yaml %(
        addons:
          homebrew:
            brewfile:
            - str
      )
      it { should serialize_to addons: { homebrew: { brewfile: 'str' } } }
      it { should have_msg [:warn, :'addons.homebrew.brewfile', :invalid_seq, value: 'str'] }
    end
  end
end

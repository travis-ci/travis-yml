describe Travis::Yml::Configs::Stages do
  let(:stages) { described_class.new(config, jobs, data) }
  let(:data) { {} }

  describe 'stage names' do
    subject { stages.apply.last.map { |job| job[:stage] } }

    describe 'no stages' do
      let(:config) { nil }
      let(:jobs) { [{ name: 'one' }, {}] }
      it { should eq [nil, nil] }
    end

    describe 'no stages section (1)' do
      let(:config) { nil }
      let(:jobs) { [{ stage: 'one' }, {}, { stage: 'two' }, {}] }
      it { should eq %w(one one two two) }
    end

    describe 'no stages section (2)' do
      let(:config) { nil }
      let(:jobs) { [{}, {}, { stage: 'one' }, {}] }
      it { should eq %w(test test one one) }
    end

    describe 'stages section' do
      let(:config) { [{ name: 'one' }, { name: 'two' } ] }
      let(:jobs) { [{ stage: 'three' }, { stage: 'two' }, {}, { stage: 'one' }, {}, { stage: 'four' }] }
      it { should eq %w(three two two one one four) }
    end
  end

  describe 'stages' do
    subject { stages.apply.first }

    describe 'no stages' do
      let(:config) { nil }
      let(:jobs) { [{ name: 'one' }, {}] }
      it { should eq [] }
    end

    describe 'no stages section (1)' do
      let(:config) { nil }
      let(:jobs) { [{ stage: 'one' }, {}, { stage: 'two' }, {}] }
      it { should eq [{ name: 'one' }, { name: 'two' }] }
    end

    describe 'no stages section (2)' do
      let(:config) { nil }
      let(:jobs) { [{}, {}, { stage: 'one' }, {}] }
      it { should eq [{ name: 'test' }, { name: 'one' }] }
    end

    describe 'stages section' do
      let(:config) { [{ name: 'one', if: 'true' }, { name: 'two' } ] }
      let(:jobs) { [{ stage: 'three' }, { stage: 'two' }, {}, { stage: 'one' }, {}, { stage: 'four' }] }

      it do
        should eq [
          { name: 'one', if: 'true' },
          { name: 'two' },
          { name: 'three' },
          { name: 'four' }
        ]
      end
    end

    describe 'stages section with an empty stage' do
      let(:config) { [{ name: 'empty' }, { name: 'one' } ] }
      let(:jobs) { [{ stage: 'one' }, { stage: 'one' }] }

      it do
        should eq [
          { name: 'one' }
        ]
      end
    end
  end

  describe 'conditional stages' do
    let(:config) { [{ name: 'one' }, { name: 'two', if: 'branch = other' } ] }
    let(:jobs) { [{ stage: 'one' }, { stage: 'two' }] }

    subject { stages.apply }

    describe 'matches' do
      let(:data) { { branch: 'other' } }

      it do
        should eq [
          [{ name: 'one' }, { name: 'two', if: 'branch = other' }],
          [{ stage: 'one' }, { stage: 'two' }]
        ]
      end
    end

    describe 'does not match' do
      let(:data) { { branch: 'master' } }

      it do
        should eq [
          [{ name: 'one' }],
          [{ stage: 'one' }]
        ]
      end
    end
  end
end

describe Travis::Yml::Configs::Stages do
  let(:stages) { described_class.new({ stages: configs }, jobs, data) }
  let(:data) { {} }

  describe 'stage names' do
    subject { stages.apply.last.map { |job| job[:stage] } }

    describe 'no stages' do
      let(:configs) { nil }
      let(:jobs) { [{ name: 'one' }, {}] }
      it { should eq [nil, nil] }
    end

    describe 'no stages section (1)' do
      let(:configs) { nil }
      let(:jobs) { [{ stage: 'one' }, {}, { stage: 'two' }, {}] }
      it { should eq %w(one one two two) }
    end

    describe 'no stages section (2)' do
      let(:configs) { nil }
      let(:jobs) { [{}, {}, { stage: 'one' }, {}] }
      it { should eq %w(test test one one) }
    end

    describe 'stages section' do
      let(:configs) { [{ name: 'one' }, { name: 'two' } ] }
      let(:jobs) { [{ stage: 'three' }, { stage: 'two' }, {}, { stage: 'one' }, {}, { stage: 'four' }] }
      it { should eq %w(three two two one one four) }
    end
  end

  describe 'stages' do
    subject { stages.apply.first }

    describe 'no stages' do
      let(:configs) { nil }
      let(:jobs) { [{ name: 'one' }, {}] }
      it { should eq [] }
    end

    describe 'no stages section (1)' do
      let(:configs) { nil }
      let(:jobs) { [{ stage: 'one' }, {}, { stage: 'two' }, {}] }
      it { should eq [{ name: 'one' }, { name: 'two' }] }
    end

    describe 'no stages section (2)' do
      let(:configs) { nil }
      let(:jobs) { [{}, {}, { stage: 'one' }, {}] }
      it { should eq [{ name: 'test' }, { name: 'one' }] }
    end

    describe 'stages section' do
      let(:configs) { [{ name: 'one', if: 'true' }, { name: 'two' } ] }
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
      let(:configs) { [{ name: 'empty' }, { name: 'one' } ] }
      let(:jobs) { [{ stage: 'one' }, { stage: 'one' }] }

      it do
        should eq [
          { name: 'one' }
        ]
      end
    end
  end

  describe 'conditional stages' do
    let(:configs) { [{ name: 'one' }, { name: 'two', if: 'branch = other' } ] }
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

  describe 'case insensitive stage names' do
    subject { stages.apply }

    describe 'stage name capitalized' do
      let(:configs) { [name: 'One'] }
      let(:jobs) { [stage: 'one'] }

      it do
        should eq [
          [{ name: 'One' }],
          [{ stage: 'one' }]
        ]
      end
    end

    describe 'job stage capitalized' do
      let(:configs) { [name: 'one'] }
      let(:jobs) { [stage: 'One'] }

      it do
        should eq [
          [{ name: 'one' }],
          [{ stage: 'One' }]
        ]
      end
    end

    describe 'default stage name out of matrix expansion' do
      let(:configs) { [{ name: 'other' }, { name: 'test' }] }
      let(:jobs) { [{}, { stage: 'other' }, { stage: 'test' }] }

      it do
        should eq [
          [{ name: 'other' }, { name: 'test' }],
          [{ stage: 'test' }, { stage: 'other' }, { stage: 'test' }]
        ]
      end
    end
  end
end

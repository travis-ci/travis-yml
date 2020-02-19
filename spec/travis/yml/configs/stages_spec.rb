describe Travis::Yml::Configs::Stages do
  let(:stages) { described_class.new(config, jobs) }

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
      it { should eq %w(One One Two Two) }
    end

    describe 'no stages section (2)' do
      let(:config) { nil }
      let(:jobs) { [{}, {}, { stage: 'one' }, {}] }
      it { should eq %w(Test Test One One) }
    end

    describe 'stages section' do
      let(:config) { [{ name: 'one' }, { name: 'two' } ] }
      let(:jobs) { [{ stage: 'three' }, { stage: 'two' }, {}, { stage: 'one' }, {}, { stage: 'four' }] }
      it { should eq %w(Three Two Two One One Four) }
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
      it { should eq [{ name: 'One' }, { name: 'Two' }] }
    end

    describe 'no stages section (2)' do
      let(:config) { nil }
      let(:jobs) { [{}, {}, { stage: 'one' }, {}] }
      it { should eq [{ name: 'Test' }, { name: 'One' }] }
    end

    describe 'stages section' do
      let(:config) { [{ name: 'one', if: 'true' }, { name: 'two' } ] }
      let(:jobs) { [{ stage: 'three' }, { stage: 'two' }, {}, { stage: 'one' }, {}, { stage: 'four' }] }
      it do
        should eq [
          { name: 'One', if: 'true' },
          { name: 'Two' },
          { name: 'Three' },
          { name: 'Four' }
        ]
      end
    end
  end
end

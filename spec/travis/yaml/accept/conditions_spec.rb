describe Travis::Yaml, 'conditions' do
  subject { described_class.apply(config) }

  describe 'build' do
    let(:cond) { subject.serialize[:if] }

    describe 'v0' do
      describe 'branch = master' do
        let(:config) { { if: 'branch = master', conditions: 'v0' } }
        it { expect(cond).to eq 'branch = master' }
      end

      describe 'true' do
        let(:config) { { if: 'true', conditions: 'v0' } }
        it { expect { subject }.to raise_error described_class::InvalidCondition }
      end
    end

    describe 'v0' do
      describe 'branch = master' do
        let(:config) { { if: 'branch = master' } }
        it { expect(cond).to eq 'branch = master' }
      end

      describe 'true' do
        let(:config) { { if: 'true' } }
        it { expect(cond).to eq 'true' }
      end
    end
  end

  describe 'stage' do
    let(:cond) { subject.serialize[:stages][0][:if] }

    describe 'v0' do
      describe 'branch = master' do
        let(:config) { { stages: [name: 'test', if: 'branch = master'], conditions: 'v0' } }
        it { expect(cond).to eq 'branch = master' }
      end

      describe 'true' do
        let(:config) { { stages: [name: 'test', if: 'true'], conditions: 'v0' } }
        it { expect { subject }.to raise_error described_class::InvalidCondition }
      end
    end

    describe 'v0' do
      describe 'branch = master' do
        let(:config) { { stages: [name: 'test', if: 'branch = master'] } }
        it { expect(cond).to eq 'branch = master' }
      end

      describe 'true' do
        let(:config) { { stages: [name: 'test', if: 'true'] } }
        it { expect(cond).to eq 'true' }
      end
    end
  end

  describe 'job' do
    let(:cond) { subject.serialize[:matrix][:include][0][:if] }

    describe 'v0' do
      describe 'branch = master' do
        let(:config) { { matrix: { include: [if: 'branch = master'] }, conditions: 'v0' } }
        it { expect(cond).to eq 'branch = master' }
      end

      describe 'true' do
        let(:config) { { matrix: { include: [if: 'true'] }, conditions: 'v0' } }
        it { expect { subject }.to raise_error described_class::InvalidCondition }
      end
    end

    describe 'v0' do
      describe 'branch = master' do
        let(:config) { { matrix: { include: [if: 'branch = master'] } } }
        it { expect(cond).to eq 'branch = master' }
      end

      describe 'true' do
        let(:config) { { matrix: { include: [if: 'true'] } } }
        it { expect(cond).to eq 'true' }
      end
    end
  end
end

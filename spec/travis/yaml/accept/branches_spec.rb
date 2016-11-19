describe Travis::Yaml, 'branches' do
  let(:msgs)     { subject.msgs }
  let(:branches) { subject.to_h[:branches] }

  subject { described_class.apply(config) }

  describe 'auto prefix' do
    describe 'accepts a string' do
      let(:config) { { branches: 'master' } }
      it { expect(branches).to eq(only: ['master']) }
    end

    describe 'accepts a regexp' do
      let(:config) { { branches: /foo/ } }
      it { expect(branches).to eq(only: [/foo/]) }
    end

    describe 'accepts a mixed array' do
      let(:config) { { branches: ['master', /dev/] } }
      it { expect(branches).to eq(only: ['master', /dev/]) }
    end
  end

  describe 'only' do
    describe 'accepts a string' do
      let(:config) { { branches: { only: 'master' } } }
      it { expect(branches).to eq(only: ['master']) }
    end

    describe 'accepts a regexp' do
      let(:config) { { branches: { only: /foo/ } } }
      it { expect(branches).to eq(only: [/foo/]) }
    end

    describe 'accepts a mixed array' do
      let(:config) { { branches: { only: ['master', /dev/] } } }
      it { expect(branches).to eq(only: ['master', /dev/]) }
    end
  end

  describe 'except' do
    describe 'accepts a string' do
      let(:config) { { branches: { except: 'master' } } }
      it { expect(branches).to eq(except: ['master']) }
    end

    describe 'accepts a regexp' do
      let(:config) { { branches: { except: /foo/ } } }
      it { expect(branches).to eq(except: [/foo/]) }
    end

    describe 'accepts a mixed array' do
      let(:config) { { branches: { except: ['master', /dev/] } } }
      it { expect(branches).to eq(except: ['master', /dev/]) }
    end
  end
end

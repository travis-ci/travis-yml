describe Travis::Yaml, 'branches' do
  let(:branches) { subject.serialize[:branches] }

  subject { described_class.apply(input) }

  describe 'auto prefix' do
    describe 'given a bool' do
      let(:input) { { branches: true } }
      it { expect(branches).to be_nil }
      it { expect(msgs).to include [:error, :branches, :invalid_type, expected: :map, actual: :bool, value: true] }
    end

    describe 'given a string' do
      let(:input) { { branches: 'master' } }
      it { expect(branches).to eq only: ['master'] }
    end

    describe 'given a regexp' do
      let(:input) { { branches: /foo/ } }
      it { expect(branches).to eq only: [/foo/] }
    end

    describe 'given a mixed array' do
      let(:input) { { branches: ['master', /dev/] } }
      it { expect(branches).to eq only: ['master', /dev/] }
    end

    describe 'given a typo on the key' do
      let(:input) { { :':branches' => 'master' } }
      it { expect(branches).to eq only: ['master'] }
    end
  end

  describe 'only' do
    describe 'given a string' do
      let(:input) { { branches: { only: 'master' } } }
      it { expect(branches).to eq only: ['master'] }
    end

    describe 'given a regexp' do
      let(:input) { { branches: { only: /foo/ } } }
      it { expect(branches).to eq only: [/foo/] }
    end

    describe 'given a mixed array' do
      let(:input) { { branches: { only: ['master', /dev/] } } }
      it { expect(branches).to eq only: ['master', /dev/] }
    end

    describe 'given an array of hashes' do
      let(:input) { { branches: [{ only: 'master' }] } }
      it { expect(branches).to eq only: ['master'] }
    end

    describe 'given a typo on the key' do
      let(:input) { { :':branches' => { :':only' => 'master' } } }
      it { expect(branches).to eq only: ['master'] }
    end
  end

  describe 'except' do
    describe 'given a string' do
      let(:input) { { branches: { except: 'master' } } }
      it { expect(branches).to eq except: ['master'] }
    end

    describe 'given a regexp' do
      let(:input) { { branches: { except: /foo/ } } }
      it { expect(branches).to eq except: [/foo/] }
    end

    describe 'given a mixed array' do
      let(:input) { { branches: { except: ['master', /dev/] } } }
      it { expect(branches).to eq except: ['master', /dev/] }
    end

    describe 'given a typo on the key' do
      let(:input) { { :':branches' => { :':except' => 'master' } } }
      it { expect(branches).to eq except: ['master'] }
    end
  end

  describe 'exclude (alias)' do
    let(:input) { { branches: { exclude: 'master' } } }
    it { expect(branches).to eq except: ['master'] }
    it { expect(info).to include [:info, :branches, :alias, alias: :exclude, key: :except] }
  end

  describe 'given an unknown key' do
    let(:input) { { branches: { foo: 'master' } } }
    it { expect(branches).to be_nil }
    it { expect(msgs).to include [:error, :branches, :unknown_key, key: :foo, value: 'master'] }
  end
end

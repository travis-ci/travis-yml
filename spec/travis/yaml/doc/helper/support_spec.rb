describe Travis::Yaml::Doc::Support do
  let(:root) { Travis::Yaml.build(language: 'ruby', os: 'linux') }
  let(:node) { Travis::Yaml::Doc::Type::Scalar.new(root, :key, 'value') }

  subject { described_class.new(node, opts).supported? }

  describe 'no conditions given' do
    let(:opts) { {} }
    it { should be true }
  end

  describe ':only given' do
    describe 'matching the current language' do
      let(:opts) { { only: { language: 'ruby' } } }
      it { should be true }
    end

    describe 'not matching the current language' do
      let(:opts) { { only: { language: 'python' } } }
      it { should be false }
    end

    describe 'matching the current os' do
      let(:opts) { { only: { os: 'linux' } } }
      it { should be true }
    end

    describe 'not matching the current os' do
      let(:opts) { { only: { os: 'osx' } } }
      it { should be false }
    end

    describe 'matching the current language but not os' do
      let(:opts) { { only: { language: 'ruby', os: 'osx' } } }
      it { should be false }
    end

    describe 'matching the current os but not language' do
      let(:opts) { { only: { language: 'python', os: 'linux' } } }
      it { should be false }
    end
  end

  describe ':except given' do
    describe 'matching the current language' do
      let(:opts) { { except: { language: 'ruby' } } }
      it { should be false }
    end

    describe 'not matching the current language' do
      let(:opts) { { except: { language: 'python' } } }
      it { should be true }
    end

    describe 'matching the current os' do
      let(:opts) { { except: { os: 'linux' } } }
      it { should be false }
    end

    describe 'not matching the current os' do
      let(:opts) { { except: { os: 'osx' } } }
      it { should be true }
    end

    describe 'matching the current language but not os' do
      let(:opts) { { except: { language: 'ruby', os: 'osx' } } }
      it { should be false }
    end

    describe 'matching the current os but not language' do
      let(:opts) { { except: { language: 'python', os: 'linux' } } }
      it { should be false }
    end
  end
end

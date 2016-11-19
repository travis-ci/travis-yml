describe Travis::Yaml::Doc::Support do
  let(:root)  { Travis::Yaml.build(input) }

  subject { described_class.new(root, opts) }

  describe 'relevant' do
    describe 'not given a language' do
      let(:input) { {} }

      describe 'not requiring a language' do
        let(:opts)  { {} }
        it { should be_relevant }
      end

      describe 'requiring a language' do
        let(:opts)  { { only: { language: [:ruby, :python] } } }
        it { should_not be_relevant }
      end

      describe 'rejecting a language' do
        let(:opts)  { { except: { language: [:ruby, :python] } } }
        it { should be_relevant }
      end
    end

    describe 'given a language' do
      let(:input) { { language: 'ruby' } }

      describe 'not requiring a language' do
        let(:opts)  { {} }
        it { should be_relevant }
      end

      describe 'requiring the same language' do
        let(:opts)  { { only: { language: [:ruby, :python] } } }
        it { should be_relevant }
      end

      describe 'requiring a different language' do
        let(:opts)  { { only: { language: [:go, :python] } } }
        it { should_not be_relevant }
      end

      describe 'rejecting the same language' do
        let(:opts)  { { except: { language: [:ruby, :python] } } }
        it { should_not be_relevant }
      end

      describe 'rejecting a different language' do
        let(:opts)  { { except: { language: [:go, :python] } } }
        it { should be_relevant }
      end
    end
  end

  describe 'supported' do
    describe 'not given a language' do
      let(:input) { {} }

      describe 'not requiring a language' do
        let(:opts)  { {} }
        it { should be_supported }
      end

      describe 'requiring a language' do
        let(:opts)  { { only: { language: [:ruby, :python] } } }
        it { should_not be_supported }
      end

      describe 'rejecting a language' do
        let(:opts)  { { except: { language: [:ruby, :python] } } }
        it { should be_supported }
      end
    end

    describe 'given a language' do
      let(:input) { { language: 'ruby' } }

      describe 'not requiring a language' do
        let(:opts)  { {} }
        it { should be_supported }
      end

      describe 'requiring the same language' do
        let(:opts)  { { only: { language: [:ruby, :python] } } }
        it { should be_supported }
      end

      describe 'requiring a different language' do
        let(:opts)  { { only: { language: [:go, :python] } } }
        it { should_not be_supported }
      end

      describe 'rejecting the same language' do
        let(:opts)  { { except: { language: [:ruby, :python] } } }
        it { should_not be_supported }
      end

      describe 'rejecting a different language' do
        let(:opts)  { { except: { language: [:go, :python] } } }
        it { should be_supported }
      end
    end
  end
end

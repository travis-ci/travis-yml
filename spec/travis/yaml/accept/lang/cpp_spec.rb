describe Travis::Yaml do
  let(:msgs)     { subject.msgs }
  let(:lang)     { subject.to_h[:language] }
  let(:compiler) { subject.to_h[:compiler] }

  subject { described_class.apply(input.merge(sudo: false)) }

  describe "language: cpp" do
    describe 'compiler' do
      describe 'defaults to gcc' do
        let(:input) { { language: 'cpp' } }
        it { expect(compiler).to eq ['gcc'] }
        it { expect(msgs).to include [:info, :compiler, :default, 'missing :compiler, defaulting to "gcc"'] }
      end

      describe 'allows a string' do
        let(:input) { { language: 'cpp', compiler: 'gcc' } }
        it { expect(compiler).to eq ['gcc'] }
        it { expect(msgs).to be_empty }
      end

      describe 'allows an array' do
        let(:input) { { language: 'cpp', compiler: ['gcc', 'clang'] } }
        it { expect(compiler).to eq ['gcc', 'clang'] }
        it { expect(msgs).to be_empty }
      end

      describe 'given an unknown value' do
        let(:input) { { language: 'cpp', compiler: 'wat' } }
        it { expect(compiler).to eq ['gcc'] }
        it { expect(msgs).to include [:error, :compiler, :unknown_value, 'dropping unknown value "wat"'] }
        it { expect(msgs).to include [:error, :compiler, :required, 'missing required key :compiler'] }
        it { expect(msgs).to include [:info, :compiler, :default, 'missing :compiler, defaulting to "gcc"'] }
      end
    end

    describe 'alias c++' do
      let(:input) { { language: 'c++' } }
      it { expect(lang).to eq 'cpp' }
      it { expect(msgs).to include [:info, :language, :alias, '"c++" is an alias for "cpp", using "cpp"'] }
    end

    describe 'alias C++' do
      let(:input) { { language: 'C++' } }
      it { expect(lang).to eq 'cpp' }
      it { expect(msgs).to include [:info, :language, :downcase, 'downcasing "C++"'] }
      it { expect(msgs).to include [:info, :language, :alias, '"c++" is an alias for "cpp", using "cpp"'] }
    end
  end

  describe 'language: ruby' do
    describe 'disallows compiler' do
      let(:input) { { language: 'ruby', compiler: 'gcc' } }
      it { expect(msgs).to include [:error, :compiler, :unsupported, 'compiler ("gcc") is not supported on language "ruby"'] }
      it { expect(compiler).to be_nil }
    end
  end
end

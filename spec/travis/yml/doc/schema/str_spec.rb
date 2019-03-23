describe Travis::Yml::Doc::Schema::Str do
  let(:schema) { described_class.new(type: :str, format: format) }

  describe 'with no format' do
    let(:format) { nil }

    describe 'matches?' do
      subject { schema.matches?(build_value(value)) }

      describe 'given a str' do
        let(:value) { 'str' }
        it { should be true }
      end

      describe 'given a num' do
        let(:value) { 1 }
        it { should be false }
      end

      describe 'given a bool' do
        let(:value) { true }
        it { should be false }
      end

      describe 'given a none' do
        let(:value) { nil }
        it { should be true }
      end

      describe 'given a seq' do
        let(:value) { ['str'] }
        it { should be false }
      end

      describe 'given a map' do
        let(:value) { { foo: 'foo' } }
        it { should be false }
      end
    end
  end

  describe 'with a format' do
    let(:format) { 'st.+' }

    describe 'matches?' do
      subject { schema.matches?(build_value(value)) }

      describe 'given a str' do
        let(:value) { 'str' }
        it { should be true }
      end

      describe 'given a str not matching the format' do
        let(:value) { '!' }
        it { should be false }
      end

      describe 'given a num' do
        let(:value) { 1 }
        it { should be false }
      end

      describe 'given a bool' do
        let(:value) { true }
        it { should be false }
      end

      describe 'given a none' do
        let(:value) { nil }
        it { should be false }
      end

      describe 'given a seq' do
        let(:value) { ['str'] }
        it { should be false }
      end

      describe 'given a map' do
        let(:value) { { foo: 'foo' } }
        it { should be false }
      end
    end
  end
end

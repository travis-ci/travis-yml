describe Travis::Yml, 'invalid_type' do
  let(:empty) { {} }

  subject { described_class.apply(value) }

  describe 'str' do
    describe 'given a str' do
      let(:value) { { language: 'ruby' } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a num' do
      let(:value) { { language: 1 } }
      it { should serialize_to language: 'ruby' }
      it { should have_msg [:info, :language, :cast, given_value: 1, given_type: :num, value: '1', type: :enum] }
      it { should have_msg [:warn, :language, :unknown_default, value: '1', default: 'ruby'] }
    end
  end

  describe 'num' do
    describe 'given a num' do
      let(:value) { { git: { depth: 1 } } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a str' do
      let(:value) { { git: { depth: 'one' } } }
      it { should serialize_to git: { depth: true } } # hmmm.
      it { should_not have_msg }
    end
  end

  describe 'bool' do
    describe 'given a bool' do
      let(:value) { { cache: { bundler: true } } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a str' do
      let(:value) { { cache: { bundler: 'true' } } }
      it { should serialize_to cache: { bundler: true } }
      it { should_not have_msg }
    end
  end

  describe 'seq' do
    describe 'given a seq' do
      let(:value) { { os: ['linux', 'osx'] } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a map' do
      let(:value) { { os: { name: 'linux' } } }
      it { should serialize_to empty }
      it { should have_msg [:error, :os, :invalid_type, expected: :seq, actual: :map, value: { name: 'linux' }] }
    end
  end

  describe 'map' do
    describe 'given a map' do
      let(:value) { { git: { strategy: 'clone' } } }
      it { should serialize_to value }
      it { should_not have_msg }
    end

    describe 'given a str' do
      let(:value) { { git: 'str' } }
      it { should serialize_to empty }
      it { should have_msg [:error, :git, :invalid_type, expected: :map, actual: :str, value: 'str'] }
    end
  end
end

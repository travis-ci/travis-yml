describe Travis::Yaml, 'matrix' do
  let(:msgs)   { subject.msgs }
  let(:matrix) { subject.to_h[:matrix] }

  subject { described_class.apply(config.merge(language: 'ruby')) }

  describe 'fast_finish' do
    let(:config) { { matrix: { fast_finish: 'true' } } }
    it { expect(matrix[:fast_finish]).to be true }
  end

  describe 'include' do
    describe 'given an array of hashes' do
      let(:config) { { matrix: { include: [{ rvm: '2.3.0' }] } } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3.0' }] }
    end

    describe 'given a hash' do
      let(:config) { { matrix: { include: { rvm: '2.3.0' } } } }
      it { expect(matrix[:include]).to eq [{ rvm: '2.3.0' }] }
    end

    describe 'given true' do
      let(:config) { { matrix: { include: true } } }
      it { expect(matrix).to be nil }
      it { expect(msgs).to include [:error, :root, :empty, 'dropping empty section :matrix'] }
      it { expect(msgs).to include [:error, :"matrix.include", :empty, 'dropping empty section :include'] }
    end

    describe 'given addons' do
      let(:config) { { matrix: { include: [addons: { apt: { packages: ['package'] } }] } } }
      it { expect(matrix[:include]).to eq [{ addons: { apt: { packages: ['package'] } } }] }
      it { expect(msgs).to be_empty }
    end
  end

  [:exclude, :allow_failures].each do |key|
    describe key.to_s do
      describe 'given an array of hashes' do
        let(:config) { { matrix: { key => [{ rvm: '2.3.0' }] } } }
        it { expect(matrix[key]).to eq [{ rvm: '2.3.0' }] }
      end

      describe 'given a hash' do
        let(:config) { { matrix: { key => { rvm: '2.3.0' } } } }
        it { expect(matrix[key]).to eq [{ rvm: '2.3.0' }] }
      end

      describe 'given true' do
        let(:config) { { matrix: { key => true } } }
        it { expect(matrix).to be nil }
        it { expect(msgs).to include [:error, :root, :empty, 'dropping empty section :matrix'] }
        it { expect(msgs).to include [:error, :"matrix.#{key}", :empty, "dropping empty section #{key.inspect}"] }
      end

      describe 'given an irrelevant key' do
        describe 'with another matcher' do
          let(:config) { { matrix: { key => [{ python: '3.5' }, { rvm: '2.3.0' }] } } }
          it { expect(matrix[key]).to eq [{ rvm: '2.3.0' }] }
          it { expect(msgs).to include [:error, :"matrix.#{key}", :unsupported, 'python ("3.5") is not supported on language "ruby"'] }
        end

        describe 'otherwise empty' do
          let(:config) { { matrix: { key => [{ python: '3.5' }] } } }
          it { expect(matrix).to be_nil }
          it { expect(msgs).to include [:error, :"matrix.#{key}", :unsupported, 'python ("3.5") is not supported on language "ruby"'] }
        end
      end
    end
  end
end

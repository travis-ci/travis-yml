describe Travis::Yaml, 'secure' do
  let(:msgs)  { subject.msgs.select { |msg| msg[0] != :info } }
  let(:value) { subject.to_h }

  subject { described_class.apply(input, opts) }

  describe 'not given :alert' do
    let(:opts)  { {} }

    describe 'given a string' do
      let(:input) { { source_key: 'key' } }
      it { expect(value[:source_key]).to eq 'key' }
      it { expect(msgs).to be_empty }
    end

    describe 'given a secure var' do
      let(:input) { { source_key: { secure: 'secure' } } }
      it { expect(value[:source_key]).to eq(secure: 'secure') }
      it { expect(msgs).to be_empty }
    end
  end

  describe 'given :alert' do
    let(:opts)  { { alert: true } }

    describe 'given a string' do
      let(:input) { { source_key: 'key' } }
      it { expect(value[:source_key]).to be_nil }
      it { expect(msgs).to include [:error, :source_key, :alert, "using a plain string as a secure"] }
    end

    describe 'given a secure var' do
      let(:input) { { source_key: { secure: 'secure' } } }
      it { expect(value[:source_key]).to eq(secure: 'secure') }
      it { expect(msgs).to be_empty }
    end
  end
end

describe Travis::Yaml do
  let(:node_js) { subject.to_h[:node_js] }
  let(:msgs)    { subject.msgs }

  subject { described_class.apply(input.merge(sudo: false)) }

  describe 'language: node_js' do
    describe 'node_js' do
      describe 'allows a string' do
        let(:input) { { language: 'node_js', node_js: '7.0.0' } }
        it { expect(node_js).to eq ['7.0.0'] }
        it { expect(msgs).to be_empty }
      end

      describe 'allows an array' do
        let(:input) { { language: 'node_js', node_js: ['7.0.0', '6', '6.1', '5.11', '0.6'] } }
        it { expect(node_js).to eq ['7.0.0', '6', '6.1', '5.11', '0.6'] }
        it { expect(msgs).to be_empty }
      end

      # describe 'drops invalid entries' do
      #   let(:input) { { language: 'node_js', node_js: ['0.8.0', '0.10.x', nil, 1.0, { foo: :bar }] } }
      #   it { expect(node_js).to be == ['0.8.0', '1.0'] }
      #   it { expect(msgs).to include([:error, :node_js, :invalid_format, 'dropping invalid format "0.10.x"']) }
      #   it { expect(msgs).to include([:error, :node_js, :invalid_format, 'dropping invalid format nil']) }
      #   it { expect(msgs).to include([:error, :node_js, :invalid_type, 'dropping unexpected Hash ({:foo=>:bar})']) }
      # end
    end

    describe 'iojs' do
      describe 'allows a string' do
        let(:input) { { language: 'node_js', node_js: 'iojs' } }
        it { expect(node_js).to eq ['iojs'] }
        it { expect(msgs).to be_empty }
      end

      describe 'allows an array' do
        let(:input) { { language: 'node_js', node_js: ['iojs', 'iojs-v1.0', 'iojs-v1.0.0'] } }
        it { expect(node_js).to eq ['iojs', 'iojs-v1.0', 'iojs-v1.0.0'] }
        it { expect(msgs).to be_empty }
      end

      # describe 'drops invalid entries' do
      #   let(:input) { { language: 'node_js', node_js: ['iojs', 'iojs-v', 'iojs-v1.x', 'iojs-v1.0.x'] } }
      #   it { expect(node_js).to be == ['iojs'] }
      #   it { expect(msgs).to include([:error, :node_js, :invalid_format, 'dropping invalid format "iojs-v"']) }
      #   it { expect(msgs).to include([:error, :node_js, :invalid_format, 'dropping invalid format "iojs-v1.x"']) }
      #   it { expect(msgs).to include([:error, :node_js, :invalid_format, 'dropping invalid format "iojs-v1.0.x"']) }
      # end
    end
  end
end

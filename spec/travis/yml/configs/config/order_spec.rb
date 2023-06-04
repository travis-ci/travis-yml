describe Travis::Yml::Configs::Config::Order, 'keep the last duplicate' do
  let(:const) do
    Class.new(Obj.new(:source, config: nil, circular: false, errored: false, matches: true)) do
      def imports
        @imports ||= []
      end

      def skip?
        !!@skip
      end

      def skip
        @skip = true
      end

      def unskip
        @skip = false
      end

      alias circular? circular
      alias errored? errored
      alias matches? matches

      def to_s
        source
      end
    end
  end

  let(:config) { const.new('.travis.yml') }

  describe 'flat' do
    before do
      0.upto(3) do |ix|
        config.imports << const.new('one.yml', ix).tap do |config|
          config.skip if skips[ix]
        end
      end
      described_class.new(config).run
    end

    describe 'unskipped 1st position' do
      let(:skips) { [false, true, true, true] }
      it { expect(config.imports.map(&:skip?)).to eq [true, true, true, false] }
    end

    describe 'unskipped 2nd position' do
      let(:skips) { [true, false, true, true] }
      it { expect(config.imports.map(&:skip?)).to eq [true, true, true, false] }
    end

    describe 'unskipped 3rd position' do
      let(:skips) { [true, true, false, true] }
      it { expect(config.imports.map(&:skip?)).to eq [true, true, true, false] }
    end

    describe 'unskipped 4th position' do
      let(:skips) { [true, true, true, false] }
      it { expect(config.imports.map(&:skip?)).to eq [true, true, true, false] }
    end
  end

  describe 'nested' do
    let(:nested) { config.imports.map { |config| config.imports }.flatten }

    before do
      config.imports << const.new('one.yml')
      config.imports << const.new('two.yml')

      0.upto(1) do |ix|
        config.imports[ix].imports << const.new('nested.yml').tap do |config|
          config.skip if skips[ix]
        end
      end

      described_class.new(config).run
    end

    describe 'unskipped 1st position' do
      let(:skips) { [false, true] }
      it { expect(nested.map(&:skip?)).to eq [true, false] }
    end

    describe 'unskipped 2nd position' do
      let(:skips) { [true, false] }
      it { expect(nested.map(&:skip?)).to eq [true, false] }
    end
  end
end

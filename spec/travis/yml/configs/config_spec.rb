describe Travis::Yml::Configs::Config::File do
  let(:ctx)  { Travis::Yml::Configs::Ctx.new }

  describe 'flatten' do
    let(:const)  do
      Class.new(described_class) do
        attr_accessor :imports, :loaded

        def initialize(ctx, parent, imports, defn)
          @imports = imports
          @path = defn['source'].split(':').last
          @ref = 'ref'
          imports.each { |child| child.parent = self }
          super(ctx, nil, defn)
        end
      end
    end

    let(:config) { const.new(ctx, nil, [build, deploy], 'source' => 'owner/repo:.travis.yml') }
    let(:build) { const.new(ctx, nil, [install_1], 'source' => 'owner/repo:build.yml') }
    let(:deploy) { const.new(ctx, nil, [install_2], 'source' => 'owner/repo:deploy.yml') }
    let(:install_1) { const.new(ctx, nil, [], 'source' => 'install.yml') }
    let(:install_2) { const.new(ctx, nil, [], 'source' => 'install.yml') }

    before { stub_repo('owner/repo', internal: true, body: {}) }

    subject { config.flatten }

    describe 'early import skipped' do
      before { install_1.skip }

      it do
        expect(subject.map(&:to_s)).to eq %w(
          owner/repo:.travis.yml@ref
          owner/repo:build.yml@ref
          owner/repo:deploy.yml@ref
          owner/repo:install.yml@ref
        )
      end
    end

    describe 'late import skipped' do
      before { install_2.skip }

      it do
        expect(subject.map(&:to_s)).to eq %w(
          owner/repo:.travis.yml@ref
          owner/repo:build.yml@ref
          owner/repo:deploy.yml@ref
          owner/repo:install.yml@ref
        )
      end
    end
  end
end

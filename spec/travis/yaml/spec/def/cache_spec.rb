describe Travis::Yaml::Spec::Def::Cache do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :alias)).to eq(
      name: :cache,
      type: :map,
      change: [
        {
          name: :cache,
          types: [
            :apt,
            :bundler,
            :cargo,
            :ccache,
            :cocoapods,
            :npm,
            :packages,
            :pip,
            :yarn
          ]
        }
      ],
      map: {
        apt: {
          key: :apt,
          types: [{ type: :scalar, cast: :bool }]
        },
        bundler: {
          key: :bundler,
          types: [{ type: :scalar, cast: :bool }]
        },
        cargo: {
          key: :cargo,
          types: [{ type: :scalar, cast: :bool }]
        },
        ccache: {
          key: :ccache,
          types: [{ type: :scalar, cast: :bool }]
        },
        cocoapods: {
          key: :cocoapods,
          types: [{ type: :scalar, cast: :bool }]
        },
        npm: {
          key: :npm,
          types: [{ type: :scalar, cast: :bool }]
        },
        packages: {
          key: :packages,
          types: [{ type: :scalar, cast: :bool }]
        },
        pip: {
          key: :pip,
          types: [{ type: :scalar, cast: :bool }]
        },
        yarn: {
          key: :yarn,
          types: [{ type: :scalar, cast: :bool }]
        },
        edge: {
          key: :edge,
          types: [{ type: :scalar, cast: :bool, edge: true }]
        },
        directories: {
          key: :directories,
          types: [{ type: :seq, types: [{ type: :scalar }] }]
        },
        timeout: {
          key: :timeout,
          types: [{ type: :scalar }]
        },
        branch: {
          key: :branch,
          types: [{ type: :scalar }]
        }
      }
    )
  end
end

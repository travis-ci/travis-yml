describe Travis::Yaml::Spec::Def::Deploy::Atlas do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :atlas,
      type: :map,
      strict: false,
      prefix: {
        key: :provider,
        type: :scalar
      }
    )
  end

  it do
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :edge)).to eq(
      token: {
        key: :token,
        types: [
          {
            type: :scalar,
            cast: [
              :secure
            ]
          }
        ]
      },
      app: {
        key: :app,
        types: [
          {
            type: :scalar
          }
        ]
      },
      exclude: {
        key: :exclude,
        types: [
          {
            type: :seq,
            types: [
              {
                type: :scalar
              }
            ]
          }
        ]
      },
      include: {
        key: :include,
        types: [
          {
            type: :seq,
            types: [
              {
                type: :scalar
              }
            ]
          }
        ]
      },
      address: {
        key: :address,
        types: [
          {
            type: :scalar
          }
        ]
      },
      vcs: {
        key: :vcs,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      },
      metadata: {
        key: :metadata,
        types: [
          {
            type: :seq,
            types: [
              {
                type: :scalar
              }
            ]
          }
        ]
      },
      debug: {
        key: :debug,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      },
      version: {
        key: :version,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
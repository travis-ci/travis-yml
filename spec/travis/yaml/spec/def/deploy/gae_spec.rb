describe Travis::Yaml::Spec::Def::Deploy::Gae do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :gae,
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
      project: {
        key: :project,
        types: [
          {
            type: :scalar
          }
        ]
      },
      keyfile: {
        key: :keyfile,
        types: [
          {
            type: :scalar
          }
        ]
      },
      config: {
        key: :config,
        types: [
          {
            type: :scalar
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
      },
      no_promote: {
        key: :no_promote,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      },
      no_stop_previous_version: {
        key: :no_stop_previous_version,
        types: [
          {
            type: :scalar,
            cast: [
              :bool
            ]
          }
        ]
      },
      verbosity: {
        key: :verbosity,
        types: [
          {
            type: :scalar
          }
        ]
      }
    )
  end
end
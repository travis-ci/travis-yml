describe Travis::Yaml::Spec::Def::Deploy::Firebase do
  let(:spec) { described_class.new.spec }

  it do
    expect(except(spec, :map)).to eq(
      name: :firebase,
      prefix: { key: :provider, type: [:str] },
      strict: false,
      type: :map,
      types: [{ name: :deploy_branches, type: :map, strict: false, deprecated: :branch_specific_option_hash }]
    )
  end

  it do
    expect(except(spec[:map], :provider, :on, :skip_cleanup, :allow_failure, :edge)).to eq(
      message: {
        key: :message,
        types: [
          { type: :scalar },
          { name: :deploy_branches, type: :map, strict: false, deprecated: :branch_specific_option_hash }
        ]
      },
      project: {
        key: :project,
        types: [
          { type: :scalar },
          { name: :deploy_branches, type: :map, strict: false, deprecated: :branch_specific_option_hash }
        ]
      },
      token: {
        key: :token,
        types: [
          { type: :scalar, secure: true },
          { name: :deploy_branches, type: :map, strict: false, deprecated: :branch_specific_option_hash }
        ]
      }
    )
  end
end

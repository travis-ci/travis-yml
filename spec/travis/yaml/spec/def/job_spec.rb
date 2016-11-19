describe Travis::Yaml::Spec::Def::Job do
  let(:spec) { Travis::Yaml.spec[:includes][:job][:map] }

  it do
    expect(spec[:osx_image]).to eq(
      key: :osx_image,
      types: [
        type: :scalar,
        edge: true,
        only: { os: :osx }
      ]
    )
  end

  it do
    expect(spec[:source_key]).to eq(
      key: :source_key,
      types: [
        type: :scalar,
        secure: true
      ]
    )
  end

  # TODO complete these
end

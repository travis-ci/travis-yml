describe Travis::Yaml::Spec::Def::Stages do
  let(:spec) { described_class.new.spec }

  it do
    expect(spec).to eq(
      name: :stages,
      type: :seq,
      types: [
        {
          name: :stage,
          type: :map,
          prefix: {
            key: :name,
            type: [:str],
          },
          map: {
            name: {
              key: :name,
              types: [type: :scalar]
            },
            if: {
              key: :if,
              types: [type: :scalar]
            }
          }
        }
      ]
    )
  end
end


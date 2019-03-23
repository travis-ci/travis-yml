describe Travis::Yaml::Spec do
  let(:type) do
    Class.new(described_class::Type::Map) do
      def define
        map :language, to: [:scalar, :seq], required: true, alias: :lang
      end
    end
  end

  let(:spec) { type.new.spec }

  it do
    expect(spec).to eq(
      type: :map,
      map: {
        language: {
          key: :language,
          types: [
            {
              type: :scalar,
              required: true,
              alias: ['lang']
            },
            {
              type: :seq,
              required: true,
              alias: ['lang'],
              types: [
                type: :scalar
              ]
            }
          ]
        }
      }
    )
  end
end

describe Travis::Yaml::Spec, 'mapping a scalar' do
  let(:type) do
    Class.new(described_class::Type::Map) do
      def initialize
        map :foo, to: :scalar, cast: :str, flagged: true, edge: true
      end
    end
  end

  it do
    expect(type.new.spec).to eq(
      name: nil,
      type: :map,
      strict: true,
      map: {
        foo: {
          key: :foo,
          types: [
            type: :scalar,
            cast: [:str],
            flagged: true,
            edge: true,
          ]
        }
      }
    )
  end
end

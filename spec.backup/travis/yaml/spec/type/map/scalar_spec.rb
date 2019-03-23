describe Travis::Yaml::Spec, 'mapping a scalar' do
  let(:type) do
    Class.new(described_class::Type::Map) do
      def define
        map :foo, to: :scalar, cast: :str, flagged: true, edge: true
      end
    end
  end

  it do
    expect(type.new.spec).to eq(
      type: :map,
      map: {
        foo: {
          key: :foo,
          types: [
            type: :scalar,
            cast: :str,
            flagged: true,
            edge: true,
          ]
        }
      }
    )
  end
end

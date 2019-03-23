describe Travis::Yaml::Spec, 'mapping a fixed' do
  let(:type) do
    Class.new(described_class::Type::Map) do
      def define
        map :foo, to: :fixed, values: [:foo, :bar]
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
            type: :fixed,
            values: [
              { value: 'foo' },
              { value: 'bar' }
            ]
          ]
        }
      }
    )
  end
end

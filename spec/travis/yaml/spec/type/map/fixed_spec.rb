describe Travis::Yaml::Spec, 'mapping a fixed' do
  let(:type) do
    Class.new(described_class::Type::Map) do
      def initialize
        map :foo, to: :fixed, values: [:foo, :bar]
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

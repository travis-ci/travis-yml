describe Travis::Yaml::Spec, 'mapping a scalar' do
  let(:type) do
    Class.new(described_class::Type::Map) do
      def initialize
        map :foo, to: :seq #, types: [type: :fixed, values: ['foo']] # TODO
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
            type: :seq,
            types: [
              {
                type: :scalar,
              }
            ]
          ]
        }
      }
    )
  end
end


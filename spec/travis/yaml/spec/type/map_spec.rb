describe Travis::Yaml::Spec do
  let(:type) do
    Class.new(described_class::Type::Map) do
      def initialize
        map :language, required: true, alias: :lang
      end
    end
  end

  it do
    expect(type.new.spec).to eq(
     name: nil,
      type: :map,
      strict: true,
      map: {
        language: {
          key: :language,
          types: [
            {
              name: :language,
              type: :fixed,
              required: true,
              alias: [
                'lang'
              ],
              defaults: [
                { value: 'ruby' }
              ],
              downcase: true,
            }
          ]
        }
      }
    )
  end
end

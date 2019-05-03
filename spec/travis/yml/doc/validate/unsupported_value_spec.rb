describe Travis::Yml::Doc::Validate, 'unsupported_value' do
  subject { described_class.apply(build_schema(schema), build_value(value, opts)) }

  describe 'map' do
    let(:schema) do
      {
        type: :object,
        properties: {
          os: {
            type: :string
          },
          dist: {
            type: :string,
            enum: [
              'trusty'
            ],
            values: {
              trusty: {
                only: {
                  os: [
                    'linux'
                  ]
                }
              }
            }
          }
        },
        additionalProperties: false
      }
    end

    describe 'given a supported value' do
      let(:value) { { os: 'linux', dist: 'trusty' } }
      it { should serialize_to os: 'linux', dist: 'trusty' }
      it { should_not have_msg }
    end

    describe 'given an unknown key' do
      let(:value) { { os: 'osx', dist: 'trusty' } }
      it { should serialize_to os: 'osx', dist: 'trusty' }
      it { should have_msg [:warn, :dist, :unsupported, on_key: 'os', on_value: 'osx', key: 'dist', value: 'trusty'] }
    end
  end
end

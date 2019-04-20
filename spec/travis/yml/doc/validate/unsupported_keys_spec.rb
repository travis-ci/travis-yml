describe Travis::Yml::Doc::Validate, 'unsupported_keys' do
  subject { described_class.apply(build_schema(schema), build_value(value)) }

  describe 'map' do
    let(:schema) do
      {
        type: :object,
        properties: {
          os: {
            type: :string
          },
          arch: {
            type: :string,
          }
        },
        additionalProperties: false,
        keys: {
          arch: {
            only: {
              os: ['linux']
            }
          }
        }
      }
    end

    describe 'given a supported key' do
      let(:value) { { os: 'linux', arch: 'str' } }
      it { should serialize_to os: 'linux', arch: 'str' }
      it { should_not have_msg }
    end

    describe 'given an unknown key' do
      let(:value) { { os: 'osx', arch: 'str' } }
      it { should serialize_to os: 'osx', arch: 'str' }
      it { should have_msg [:warn, :arch, :unsupported, on_key: :os, on_value: 'osx', key: :arch, value: 'str'] }
    end
  end
end

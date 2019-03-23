describe Travis::Yml::Schema::Json::Enum do
  let(:node) { Travis::Yml::Schema::Dsl::Enum.new(nil, opts) }

  subject { described_class.new(node.node) }

  describe 'given a number of values' do
    let(:opts) { { values: ['one', 'two'] } }

    it do
      should have_schema(
        type: :string,
        enum: ['one', 'two']
      )
    end
  end

  describe 'given a value with only' do
    let(:opts) { { values: [value: 'one', only: { os: 'linux' }] } }

    it do
      should have_schema(
        type: :string,
        enum: ['one'],
        values: {
          one: {
            only: {
              os: ['linux']
            }
          }
        }
      )
    end
  end

  describe 'given a value with except' do
    let(:opts) { { values: [value: 'one', except: { os: 'linux' }] } }

    it do
      should have_schema(
        type: :string,
        enum: ['one'],
        values: {
          one: {
            except: {
              os: ['linux']
            }
          }
        }
      )
    end
  end

  describe 'given a value with deprecated' do
    let(:opts) { { values: [value: 'one', deprecated: true] } }

    it do
      should have_schema(
        type: :string,
        enum: ['one'],
        values: {
          one: {
            deprecated: true
          }
        }
      )
    end
  end
end

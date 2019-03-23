describe Travis::Yml::Schema::Json::Seq do
  let(:node) { Travis::Yml::Schema::Dsl::Seq.new(nil, opts) }
  let(:opts) { {} }

  subject { described_class.new(node.node) }

  it { should_not have_definitions }

  describe 'type' do
    describe 'given :str' do
      let(:opts) { { type: :str } }

      it do
        should have_schema(
          '$ref': '#/definitions/strs'
        )
      end
    end

    describe 'given :str with options' do
      let(:opts) { { type: :str, edge: true } }

      it do
        should have_schema(
          '$ref': '#/definitions/strs',
          flags: [:edge]
        )
      end
    end

    describe 'given :secure' do
      let(:opts) { { type: :secure } }

      it do
        should have_schema(
          '$ref': '#/definitions/secures'
        )
      end
    end

    describe 'given :secure with options' do
      let(:opts) { { type: :secure, edge: true } }

      it do
        should have_schema(
          '$ref': '#/definitions/secures',
          flags: [:edge]
        )
      end
    end

    describe 'given :num' do
      let(:opts) { { type: :num } }

      it do
        should have_schema(
          anyOf: [
            {
              type: :array,
              items: {
                type: :number
              },
              normal: true
            },
            {
              type: :number
            }
          ]
        )
      end
    end

    describe 'given a custom type, not exported' do
      let(:opts) { { type: type } }

      let(:type) do
        Class.new(Travis::Yml::Schema::Dsl::Str) do
          def define
            edge
          end
        end
      end

      it do
        should have_schema(
          anyOf: [
            {
              type: :array,
              items: {
                type: :string,
                flags: [:edge]
              },
              normal: true
            },
            {
              type: :string,
              flags: [:edge]
            }
          ]
        )
      end
    end

    describe 'given a custom type, exported' do
      let(:opts) { { type: type } }

      let(:type) do
        Class.new(Travis::Yml::Schema::Dsl::Str) do
          register :one

          def define
            edge
            export
          end
        end
      end

      it do
        should have_definitions(
          type: {
            one: {
              '$id': :one,
              title: 'One',
              type: :string,
              flags: [:edge]
            }
          }
        )
      end

      it do
        should have_schema(
          anyOf: [
            {
              type: :array,
              items: {
                '$ref': '#/definitions/type/one'
              },
              normal: true
            },
            {
              '$ref': '#/definitions/type/one'
            }
          ]
        )
      end
    end
  end
end

describe Travis::Yml::Doc, 'messages', alert: true, defaults: true, empty: true, line: true, support: true do
  let(:schema) do
    {
      type: :object,
      properties: {
        one: {
          type: :string,
          enum: [
            'one',
            '1'
          ],
          downcase: true,
          defaults: [
            value: 'uno'
          ],
          values: {
            one: {
              aliases: [
                'uno'
              ]
            },
            '1': {
              deprecated: 'deprecation'
            }
          },
          aliases: [
            'uno'
          ],
          flags: [
            :edge
          ],
          deprecated: 'deprecation',
        }
      },
      required: [
        :one
      ],
      additionalProperties: false
    }
  end

  subject { described_class.apply(build_schema(schema), parse(yaml), opts) }

  describe 'alias (key)' do
    yaml 'uno: one'
    it { should serialize_to one: 'one' }
    it { should have_msg [:info, :root, :alias, type: :key, alias: 'uno', obj: 'one', line: 0] }
  end

  describe 'alias (value)' do
    yaml 'one: uno'
    it { should serialize_to one: 'one' }
    it { should have_msg [:info, :one, :alias, type: :value, alias: 'uno', obj: 'one', line: 0] }
  end

  describe 'cast' do
    yaml 'one: 1'
    it { should serialize_to one: '1' }
    # it { should have_msg [:info, :one, :cast, given_value: 1, given_type: :num, value: '1', type: :str, line: 0] }
  end

  describe 'default' do
    yaml 'two: duo'
    it { should serialize_to one: 'uno', two: 'duo' }
    it { should have_msg [:info, :one, :default, key: 'one', default: 'uno'] }
  end

  describe 'deprecated' do
    # unused
  end

  describe 'deprecated_key' do
    yaml 'one: one'
    it { should have_msg [:warn, :root, :deprecated_key, key: 'one', info: 'deprecation', line: 0] }
  end

  describe 'deprecated_value' do
    yaml 'one: "1"'
    it { should have_msg [:warn, :one, :deprecated_value, value: '1', info: 'deprecation', line: 0] }
  end

  describe 'downcase' do
    yaml 'one: ONE'
    it { should have_msg [:info, :one, :downcase, value: 'ONE', line: 0] }
  end

  describe 'duplicate' do
  end

  describe 'edge' do
    yaml 'one: one'
    it { should have_msg [:info, :one, :edge, line: 0] }
  end

  describe 'flagged' do
    # unused
  end

  describe 'required' do
    let(:schema) { { type: :object, properties: { one: { type: :string } }, required: [:one] } }
    yaml 'two: two'
    it { should have_msg [:error, :root, :required, key: 'one'] }
  end

  describe 'secure' do
    let(:schema) do
      {
        type: :object,
        properties: {
          one: {
            '$id': :secure,
            anyOf: [
              {
                type: :object,
                properties: {
                  secure: {
                    type: :string
                  }
                },
                additionalProperties: false,
                maxProperties: 1,
                normal: true
              },
              {
                type: :string,
                normal: true
              }
            ]
          }
        }
      }
    end
    yaml 'one: one'
    it { should have_msg [:alert, :one, :secure, type: :str, line: 0] }
  end

  describe 'empty' do
    let(:schema) { { type: :object, properties: { one: { type: :array, items: { type: :string } } } } }
    yaml 'one:'
    it { should have_msg [:warn, :one, :empty, key: 'one', line: 0] }
  end

  describe 'find_key' do
    yaml 'ones: one'
    it { should have_msg [:warn, :root, :find_key, original: 'ones', key: 'one', line: 0] }
  end

  describe 'find_value' do
    yaml 'one: ones'
    it { should have_msg [:warn, :one, :find_value, original: 'ones', value: 'one', line: 0] }
  end

  describe 'clean_key' do
    yaml 'one!: one'
    it { should have_msg [:warn, :root, :clean_key, original: 'one!', key: 'one', line: 0] }
  end

  describe 'clean_value' do
    yaml 'one: one!!'
    it { should have_msg [:warn, :one, :clean_value, original: 'one!!', value: 'one', line: 0] }
  end

  describe 'strip_key' do
    yaml '"one ": one'
    it { should have_msg [:warn, :root, :strip_key, original: 'one ', key: 'one', line: 0] }
  end

  describe 'underscore_key' do
    yaml 'One: one'
    it { should have_msg [:info, :root, :underscore_key, original: 'One', key: 'one', line: 0] }
  end

  describe 'unexpected_seq' do
    yaml %(
      one:
      - one
    )
    it { should have_msg [:warn, :one, :unexpected_seq, value: 'one', line: 1] }
  end

  describe 'unknown_key' do
    yaml 'unknown: str'
    it { should have_msg [:warn, :root, :unknown_key, key: 'unknown', value: 'str', line: 0] }
  end

  describe 'unknown_value' do
    let(:schema) { { type: :object, properties: { one: { type: :string, enum: ['uno'] } } } }
    yaml 'one: unknown'
    it { should have_msg [:error, :one, :unknown_value, value: 'unknown', line: 0] }
  end

  describe 'unknown_default' do
    yaml 'one: two'
    it { should have_msg [:warn, :one, :unknown_default, value: 'two', default: 'uno', line: 0] }
  end

  describe 'unknown_var' do
    let(:schema) { { type: :object, properties: { one: { type: :string, vars: ['var'] } } } }
    yaml 'one: "%{unknown}"'
    it { should have_msg [:warn, :one, :unknown_var, var: 'unknown', line: 0] }
  end

  describe 'unsupported (key)' do
    let(:schema) do
      {
        type: :object,
        properties: {
          os: {
            type: :string,
          },
          one: {
            type: :string,
            only: {
              os: [
                'linux'
              ]
            }
          }
        }
      }
    end
    yaml %(
      os: macosx
      one: one
    )
    it { should have_msg [:warn, :one, :unsupported, on_key: 'os', on_value: 'macosx', key: 'one', value: 'one', line: 2] }
  end

  describe 'unsupported (value)' do
    let(:schema) do
      {
        type: :object,
        properties: {
          os: {
            type: :string,
          },
          one: {
            type: :string,
            enum: [
              'one'
            ],
            values: {
              one: {
                only: {
                  os: [
                    'linux'
                  ]
                }
              }
            }
          }
        }
      }
    end
    yaml %(
      os: macosx
      one: one
    )
    it { should have_msg [:warn, :one, :unsupported, on_key: 'os', on_value: 'macosx', key: 'one', value: 'one', line: 2] }
  end

  describe 'invalid_type' do
    yaml %(
      one:
        two: str
    )
    it { should have_msg [:error, :one, :invalid_type, expected: :str, actual: :map, value: { two: 'str' }, line: 1] }
  end

  describe 'invalid_format' do
    let(:schema) { { type: :object, properties: { one: { type: :string, format: '^\d+$' } } } }
    yaml 'one: uno'
    it { should have_msg [:error, :one, :invalid_format, format: '^\d+$', value: 'uno', line: 0] }
  end

  describe 'invalid_condition' do
    let(:schema) { { type: :object, properties: { if: { type: :string } } } }
    yaml 'if: not'
    it { should have_msg [:error, :if, :invalid_condition, condition: 'not', line: 0] }
  end

  describe 'invalid_env_var' do
    let(:schema) do
      {
        type: :object,
        properties: {
          env: {
            type: :array,
            items: {
              type: :string,
            },
            changes: [
              change: :env_vars
            ]
          }
        }
      }
    end
    yaml 'env: [FOO="]'
    it { should have_msg [:error, :env, :invalid_env_var, var: 'FOO="', line: 0] }
  end
end

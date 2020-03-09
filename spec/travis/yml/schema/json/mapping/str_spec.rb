describe Travis::Yml::Schema::Json::Map, 'mapping to any node' do
  def const(define)
    Class.new(Travis::Yml::Schema::Type::Map) do
      define_method(:define, &define)
    end
  end

  subject { const(define).new }

  describe 'alias' do
    let(:define) { -> { map :foo, to: :str, alias: :bar } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            aliases: [
              :bar
            ]
          }
        },
        additionalProperties: false
      )
    end
  end

  describe 'change' do
    let(:define) { -> { map :foo, to: :str, change: :change } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            changes: [
              {
                change: :change
              }
            ]
          }
        },
        additionalProperties: false
      )
    end
  end

  describe 'deprecated' do
    let(:define) { -> { map :foo, to: :str, deprecated: 'deprecated' } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            deprecated: 'deprecated'
          }
        },
        additionalProperties: false,
      )
    end
  end

  describe 'edge' do
    let(:define) { -> { map :foo, to: :str, edge: true } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            flags: [
              :edge
            ]
          }
        },
        additionalProperties: false,
      )
    end
  end

  describe 'ignore_case' do
    let(:define) { -> { map :foo, to: :str, ignore_case: true } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            ignore_case: true
          }
        },
        additionalProperties: false,
      )
    end
  end

  describe 'internal' do
    let(:define) { -> { map :foo, to: :str, internal: true } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            flags: [
              :internal
            ]
          }
        },
        additionalProperties: false,
      )
    end
  end

  # describe 'expand' do
  #   before { const.map :foo, to: :str, expand: true }
  #   it { should_not include expand: anything }
  #   it { should_not include properties: { foo: hash_including(expand: anything) } }
  # end

  describe 'default' do
    let(:define) { -> { map :foo, to: :str, default: 'str' } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            defaults: [
              value: 'str'
            ]
          }
        },
        additionalProperties: false,
      )
    end
  end

  describe 'required' do
    let(:define) { -> { map :foo, to: :str, required: true } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
          }
        },
        additionalProperties: false,
        required: [
          :foo
        ]
      )
    end
  end

  describe 'unique' do
    let(:define) { -> { map :foo, to: :str, unique: true } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            flags: [
              :unique
            ]
          }
        },
        additionalProperties: false,
      )
    end
  end

  describe 'only' do
    let(:define) { -> { map :foo, to: :str, only: { os: 'linux' } } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            only: {
              os: [
                'linux'
              ]
            }
          }
        },
        additionalProperties: false
      )
    end
  end

  describe 'except' do
    let(:define) { -> { map :foo, to: :str, except: { os: 'linux' } } }

    it do
      should have_schema(
        type: :object,
        properties: {
          foo: {
            type: :string,
            except: {
              os: [
                'linux'
              ]
            }
          }
        },
        additionalProperties: false
      )
    end
  end
end

describe Travis::Yml::Schema::Form, 'seq' do
  def const(define)
    Class.new(Travis::Yml::Schema::Type::Seq) do
      define_method(:define, &define)
    end
  end

  subject { Travis::Yml::Schema::Type::Node.build(const(define)).to_h }

  describe 'given :str' do
    let(:define) { -> { types :str } }

    it do
      should eq(
        {
          type: :ref,
          id: :strs,
          ref: :'type/strs'
        }
      )
    end
  end

  describe 'given :str with an opt' do
    let(:define) { -> { types :str, edge: true } }

    it do
      should eq(
        {
          type: :any,
          types: [
            {
              type: :seq,
              normal: true,
              types: [
                {
                  type: :str,
                  flags: [
                    :edge
                  ]
                }
              ],
            },
            {
              type: :str,
              flags: [
                :edge
              ]
            }
          ]
        }
      )
    end
  end

  describe 'given :bool' do
    let(:define) { -> { types :bool } }

    it do
      should eq(
        {
          type: :any,
          types: [
            {
              type: :seq,
              types: [
                type: :bool
              ],
              normal: true
            },
            {
              type: :bool
            }
          ]
        }
      )
    end
  end

  describe 'given a map with a prefix' do
    let!(:foo) do
      Class.new(Travis::Yml::Schema::Type::Map) do
        register :foo

        def define
          prefix :foo
          map :foo, to: :str
        end
      end
    end

    let(:define) { -> { types :foo } }

    after { foo.unregister }

    it do
      should eq(
        {
          type: :any,
          types: [
            {
              type: :seq,
              normal: true,
              types: [
                {
                  type: :any,
                  types: [
                    {
                      type: :map,
                      normal: true,
                      prefix: {
                        key: :foo
                      },
                      map: {
                        foo: {
                          type: :str
                        }
                      }
                    },
                    {
                      type: :str
                    }
                  ]
                }
              ]
            },
            {
              type: :any,
              types: [
                {
                  type: :map,
                  normal: true,
                  prefix: {
                    key: :foo
                  },
                  map: {
                    foo: {
                      type: :str
                    }
                  }
                },
                {
                  type: :str
                }
              ]
            }
          ]
        }
      )
    end
  end
end

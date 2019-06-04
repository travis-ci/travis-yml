describe Travis::Yml::Schema::Type::Form, 'map' do
  def const(define)
    Class.new(Travis::Yml::Schema::Type::Map) do
      define_method(:define, &define)
    end
  end

  subject { Travis::Yml::Schema::Type::Node.build(const(define)).to_h }

  describe 'default' do
    let(:define) { -> { map :foo, to: :str } }

    it do
      should eq(
        {
          type: :map,
          map: {
            foo: {
              type: :str
            }
          }
        }
      )
    end
  end

  describe 'with a map' do
    let!(:foo) do
      Class.new(Travis::Yml::Schema::Type::Map) do
        register :foo

        def define
          map :bar, to: :str
        end
      end
    end

    let(:define) { -> { map :foo, to: :foo } }

    after { foo.unregister }

    it do
      should eq(
        {
          type: :map,
          map: {
            foo: {
              type: :map,
              map: {
                bar: {
                  type: :str
                }
              }
            }
          }
        }
      )
    end
  end

  describe 'with a seq (default :str)' do
    let(:define) { -> { map :foo, to: :seq } }

    it do
      should eq(
        {
          type: :map,
          map: {
            foo: {
              type: :ref,
              id: :strs,
              ref: :'type/strs'
            }
          }
        }
      )
    end
  end

  describe 'with a seq (:str)' do
    let(:define) { -> { map :foo, to: :seq, type: :str } }

    it do
      should eq(
        {
          type: :map,
          map: {
            foo: {
              type: :ref,
              id: :strs,
              ref: :'type/strs'
            }
          }
        }
      )
    end
  end

  describe 'with a seq (:num)' do
    let(:define) { -> { map :foo, to: :seq, type: :num } }

    it do
      should eq(
        {
          type: :map,
          map: {
            foo: {
              type: :any,
              types: [
                {
                  type: :seq,
                  normal: true,
                  types: [
                    {
                      type: :num
                    }
                  ]
                },
                {
                  type: :num
                }
              ]
            }
          }
        }
      )
    end
  end

  describe 'with a prefix' do
    let(:define) do
      -> do
        prefix :foo
        map :foo, to: :str
      end
    end

    it do
      should eq(
        type: :any,
        types: [
          {
            type: :map,
            prefix: {
              key: :foo,
            },
            normal: true,
            map: {
              foo: {
                type: :str
              }
            },
          },
          {
            type: :str,
          }
        ]
      )
    end
  end

  describe 'nested with prefixes' do
    let!(:foo) do
      Class.new(Travis::Yml::Schema::Type::Map) do
        register :foo

        def define
          prefix :bar
          map :bar, to: :str
        end
      end
    end

    let(:define) do
      -> do
        prefix :foo
        map :foo, to: :foo
      end
    end

    after { foo.unregister }

    it do
      should eq(
        type: :any,
        types: [
          {
            type: :map,
            prefix: {
              key: :foo,
            },
            normal: true,
            map: {
              foo: {
                type: :any,
                types: [
                  {
                    type: :map,
                    normal: true,
                    prefix: {
                      key: :bar,
                    },
                    map: {
                      bar: {
                        type: :str
                      }
                    }
                  },
                  {
                    type: :str
                  }
                ]
              }
            },
          },
          {
            type: :any,
            types: [
              {
                type: :map,
                normal: true,
                prefix: {
                  key: :bar
                },
                map: {
                  bar: {
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
      )
    end
  end

  describe 'with change: :enable' do
    let(:define) do
      -> do
        map :foo, to: :str
        change :enable
      end
    end

    it do
      should eq(
        {
          type: :any,
          types: [
            {
              type: :map,
              changes: [
                {
                  change: :enable
                }
              ],
              normal: true,
              map: {
                foo: {
                  type: :str
                }
              },
            },
            {
              type: :bool,
            }
          ]
        }
      )
    end
  end

  describe 'with a type' do
    let(:define) { -> { types :str } }

    it do
      should eq(
        type: :any,
        types: [
          {
            type: :map,
            types: [
              type: :str
            ]
          },
          {
            type: :str,
          }
        ]
      )
    end
  end
end

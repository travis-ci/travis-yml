describe Travis::Yml::Schema::Type::Expand, 'map' do
  let(:dsl)  { Travis::Yml::Schema::Dsl::Map.new }

  subject { described_class.apply(dsl.node).to_h }

  describe 'default' do
    before do
      dsl.map :foo, to: :str
    end

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
    let(:map) do
      Class.new(Travis::Yml::Schema::Dsl::Map) do
        def define
          map :bar, to: :str
        end
      end
    end

    before do
      dsl.map :foo, to: map
    end

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

  describe 'with a seq' do
    before do
      dsl.map :foo, to: :seq
    end

    it do
      should eq(
        {
          type: :map,
          map: {
            foo: {
              type: :ref,
              ref: 'strs'
            }
          }
        }
      )
    end
  end

  describe 'with a prefix' do
    before do
      dsl.prefix :foo
      dsl.map :foo, to: :str
    end

    it do
      should eq(
        type: :any,
        schemas: [
          {
            type: :map,
            prefix: :foo,
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
    let(:map) do
      Class.new(Travis::Yml::Schema::Dsl::Map) do
        def define
          prefix :bar
          map :bar, to: :str
        end
      end
    end

    before do
      dsl.prefix :foo
      dsl.map :foo, to: map
    end

    it do
      should eq(
        type: :any,
        schemas: [
          {
            type: :map,
            prefix: :foo,
            normal: true,
            map: {
              foo: {
                type: :any,
                schemas: [
                  {
                    type: :map,
                    prefix: :bar,
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
            type: :map,
            prefix: :bar,
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
      )
    end
  end

  describe 'with change: :enable' do
    before do
      dsl.map :foo, to: :str
      dsl.change :enable
    end

    xit do
      should eq(
        {
          type: :any,
          schemas: [
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
end

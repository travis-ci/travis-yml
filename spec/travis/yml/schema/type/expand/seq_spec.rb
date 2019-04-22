describe Travis::Yml::Schema::Type::Expand, 'seq' do
  let(:dsl) { Travis::Yml::Schema::Dsl::Seq.new }

  subject { described_class.apply(dsl.node).to_h }

  after { Travis::Yml::Schema::Type::Node.exports.clear } # hmmm.

  before do
    dsl.type *types
    dsl.export
  end

  describe 'given :str' do
    let(:types) { [:str] }

    it do
      should eq(
        {
          type: :ref,
          export: true,
          ref: 'strs',
        }
      )
    end
  end

  describe 'given :str with an opt' do
    let(:types) { [:str, edge: true] }

    it do
      should eq(
        {
          type: :ref,
          export: true,
          ref: 'strs',
          flags: [
            :edge
          ]
        }
      )
    end
  end

  describe 'given :bool' do
    let(:types) { :bool }

    it do
      should eq(
        {
          type: :any,
          export: true,
          schemas: [
            {
              type: :seq,
              schemas: [
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
    let(:map) do
      Class.new(Travis::Yml::Schema::Dsl::Map) do
        def define
          prefix :foo
          map :foo, to: :str
        end
      end
    end

    let(:types) { [map] }

    it do
      should eq(
        {
          type: :any,
          export: true,
          schemas: [
            {
              type: :seq,
              normal: true,
              schemas: [
                {
                  type: :map,
                  prefix: :foo,
                  map: {
                    foo: {
                      type: :str
                    }
                  }
                }
              ]
            },
            {
              type: :map,
              prefix: :foo,
              map: {
                foo: {
                  type: :str
                }
              }
            },
            {
              type: :seq,
              schemas: [
                {
                  type: :str
                }
              ]
            },
            {
              type: :str
            }
          ]
        }
      )
    end
  end
end

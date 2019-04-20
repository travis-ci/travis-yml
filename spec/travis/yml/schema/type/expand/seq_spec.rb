describe Travis::Yml::Schema::Type::Expand, 'seq', skip: true do
  describe 'a seq' do
    let(:dsl) { Travis::Yml::Schema::Dsl::Seq.new }

    subject { described_class.apply(dsl.node).to_h }

    after { Travis::Yml::Schema::Type::Node.exports.clear } # hmmm.

    before do
      dsl.type *types
      dsl.export
    end

    describe 'given :strt' do
      let(:types) { [:str] }

      it do
        should eq(
          {
            type: :ref,
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
            schemas: [
              {
                type: :seq,
                schemas: [
                  {
                    type: :any,
                    schemas: [
                      {
                        type: :map,
                        opts: {
                          prefix: :foo
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
                schemas: [
                  {
                    type: :map,
                    opts: {
                      prefix: :foo
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
end

describe Travis::Yml::Schema::Type::Map do
  subject { const.new[:key].to_h }

  describe 'map :exported' do
    let!(:one) do
      Class.new(Travis::Yml::Schema::Type::Bool) do
        register :one

        def define
          id :one
          export
        end
      end
    end

    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :seq, type: :one, title: 'mapped title'
        end
      end
    end

    it do
      should eq(
        type: :any,
        title: 'mapped title',
        types: [
          {
            type: :seq,
            normal: true,
            types: [
              type: :ref,
              id: :one,
              ref: :'type/one'
            ]
          },
          {
            type: :ref,
            id: :one,
            ref: :'type/one'
          }
        ]
      )
    end
  end

  describe 'map seq (default :str)' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :seq
        end
      end
    end

    it do
      should eq(
        type: :ref,
        id: :strs,
        ref: :'type/strs'
      )
    end
  end

  describe 'map seq(:str)' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :seq, type: :str
        end
      end
    end

    it do
      should eq(
        type: :ref,
        id: :strs,
        ref: :'type/strs'
      )
    end
  end

  describe 'map seq(:num)' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :seq, type: :num
        end
      end
    end

    it do
      should eq(
        type: :any,
        types: [
          {
            type: :seq,
            normal: true,
            types: [
              type: :num
            ]
          },
          {
            type: :num
          }
        ]
      )
    end
  end
end

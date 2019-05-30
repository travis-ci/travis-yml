describe Travis::Yml::Schema::Type::Seq do
  def build(*args)
    Travis::Yml::Schema::Type::Node.build(*args)
  end

  describe 'exported type' do
    let!(:one) do
      Class.new(Travis::Yml::Schema::Type::Bool) do
        register :one

        def define
          id :one
          title 'defined one'
          edge
          export
        end
      end
    end

    let(:const) do
      Class.new(described_class) do
        register :const

        def define
          types :one, title: 'mapped one'
        end
      end
    end

    after do
      const.unregister
      one.unregister
      one.exports.delete(:'type/one')
    end

    let(:export) { const.exports[:'type/one'] }
    let!(:node)  { const.build(:const) }

    describe 'export' do
      subject { export }
      it { should be_a one }
      it { should have_opt title: 'defined one' }
    end

    it 'node' do
      expect(node.to_h).to eq(
        type: :any,
        types: [
          {
            type: :seq,
            normal: true,
            types: [
              {
                type: :ref,
                ref: :'type/one',
                id: :one,
                title: 'mapped one'
              }
            ]
          },
          {
            type: :ref,
            ref: :'type/one',
            id: :one
          }
        ]
      )
    end
  end

  describe 'strs' do
    let(:const) do
      Class.new(described_class)
    end

    describe 'new' do
      subject { const.new.to_h }

      it do
        should eq(
          type: :seq,
          types: []
        )
      end
    end

    describe 'build' do
      subject { build(const).to_h }

      it do
        should eq(
          type: :ref,
          ref: :'type/strs',
          id: :strs
        )
      end
    end
  end

  describe 'secures' do
    let(:const) do
      Class.new(described_class) do
        def define
          types :secure
        end
      end
    end

    describe 'new' do
      subject { const.new.to_h }

      it do
        should eq(
          type: :seq,
          types: [
            type: :ref,
            ref: :'type/secure',
            id: :secure
          ]
        )
      end
    end

    describe 'build' do
      subject { build(const).to_h }

      it do
        should eq(
          type: :ref,
          ref: :'type/secures',
          id: :secures
        )
      end
    end
  end
end

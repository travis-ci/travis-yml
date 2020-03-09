describe Travis::Yml::Schema::Type::Map do
  subject { const.new.to_h }

  describe 'default' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :str
        end
      end
    end

    it do
      should eq(
        type: :map,
        map: {
          key: {
            type: :str
          }
        }
      )
    end
  end

  describe 'flag' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :str, edge: true
        end
      end
    end

    it do
      should eq(
        type: :map,
        map: {
          key: {
            type: :str,
            flags: [
              :edge
            ]
          }
        }
      )
    end
  end

  describe 'typed map' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :map, type: :str
        end
      end
    end

    it do
      should eq(
        type: :map,
        map: {
          key: {
            type: :any,
            types: [
              {
                type: :map,
                types: [
                  type: :str
                ],
              },
              {
                type: :str
              }
            ]
          }
        }
      )
    end
  end

  describe 'unstrict map' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :map, strict: false
        end
      end
    end

    it do
      should eq(
        type: :map,
        map: {
          key: {
            type: :map,
            strict: false
          }
        }
      )
    end
  end

  describe 'default (1)' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :str, default: 'one'
        end
      end
    end

    it do
      should eq(
        type: :map,
        map: {
          key: {
            type: :str,
            defaults: [
              { value: 'one' }
            ]
          }
        }
      )
    end
  end

  describe 'default (2)' do
    let(:const) do
      Class.new(described_class) do
        def define
          map :key, to: :str, default: [value: 'one', only: { os: 'linux' }]
        end
      end
    end

    it do
      should eq(
        type: :map,
        map: {
          key: {
            type: :str,
            defaults: [
              { value: 'one', only: { os: ['linux'] } }
            ]
          }
        }
      )
    end
  end
end

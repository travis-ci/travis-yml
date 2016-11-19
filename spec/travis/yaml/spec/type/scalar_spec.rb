describe Travis::Yaml::Spec::Type::Scalar do
  let(:type) do
    Class.new(described_class) do
      def define
        cast :secure
        default 'foo'
        downcase
        flagged
        edge

        only language: :java
        except os: :osx

        normalize :foo
        validate :bar
      end
    end
  end

  it do
    expect(type.new.spec).to eq(
      name: nil,
      type: :scalar,
      cast: [:secure],
      defaults: [value: 'foo'],
      downcase: true,
      edge: true,
      flagged: true,
      only: { language: ['java'] },
      except: { os: ['osx'] },
      normalize: [{ name: :foo }],
      conform: [{ name: :bar, stage: :validate }]
    )
  end
end

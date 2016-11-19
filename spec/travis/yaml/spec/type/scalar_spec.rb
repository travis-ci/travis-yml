describe Travis::Yaml::Spec::Type::Scalar do
  let(:type) do
    Class.new(described_class) do
      def define
        secure
        default 'foo'
        downcase
        flagged
        edge

        only language: :java
        except os: :osx

        change :foo
        validate :bar
      end
    end
  end

  it do
    expect(type.new.spec).to eq(
      name: nil,
      type: :scalar,
      secure: true,
      defaults: [value: 'foo'],
      downcase: true,
      edge: true,
      flagged: true,
      only: { language: ['java'] },
      except: { os: ['osx'] },
      change: [{ name: :foo }],
      validate: [{ name: :bar }]
    )
  end
end

describe Travis::Yml::Schema::Def::Scala, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:scala] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :scala,
        title: 'Scala',
        type: :object,
        properties: {
          scala: {
            '$ref': '#/definitions/strs'
          },
          jdk: {
            '$ref': '#/definitions/strs'
          },
          sbt_args: {
            type: :string
          }
        },
        normal: true,
        only: {
          scala: {
            language: [
              'scala'
            ]
          },
          jdk: {
            language: [
              'scala'
            ]
          },
          sbt_args: {
            language: [
              'scala'
            ]
          }
        },
        except: {
          jdk: {
            os: [
              'osx'
            ]
          }
        }
      )
    end
  end

  # describe 'schema' do
  #   subject { described_class.new.schema }
  #
  #   it do
  #     should eq(
  #       '$ref': '#/definitions/language/scala'
  #     )
  #   end
  # end
end

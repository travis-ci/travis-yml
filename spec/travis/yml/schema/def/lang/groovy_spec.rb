describe Travis::Yml::Schema::Def::Groovy, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:groovy] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :groovy,
        title: 'Groovy',
        type: :object,
        properties: {
          jdk: {
            '$ref': '#/definitions/strs'
          }
        },
        normal: true,
        only: {
          jdk: {
            language: [
              'groovy'
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
  #       '$ref': '#/definitions/language/groovy'
  #     )
  #   end
  # end
end

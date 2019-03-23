describe Travis::Yml::Schema::Def::Java, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:java] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :java,
        title: 'Java',
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
              'java'
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

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/java'
      )
    end
  end
end

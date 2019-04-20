describe Travis::Yml::Schema::Def::Clojure, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:clojure] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :clojure,
        title: 'Clojure',
        type: :object,
        properties: {
          jdk: {
            '$ref': '#/definitions/strs'
          },
          lein: {
            type: :string
          }
        },
        normal: true,
        only: {
          jdk: {
            language: [
              'clojure'
            ]
          },
          lein: {
            language: [
              'clojure'
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
  #       '$ref': '#/definitions/language/clojure'
  #     )
  #   end
  # end
end

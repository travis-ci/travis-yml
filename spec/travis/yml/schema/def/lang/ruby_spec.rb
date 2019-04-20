describe Travis::Yml::Schema::Def::Ruby, 'structure' do
  describe 'definitions' do
    subject { Travis::Yml.schema[:definitions][:language][:ruby] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should eq(
        '$id': :ruby,
        title: 'Ruby',
        type: :object,
        properties: {
          rvm: {
            '$ref': '#/definitions/strs'
          },
          gemfile: {
            '$ref': '#/definitions/strs'
          },
          jdk: {
            '$ref': '#/definitions/strs'
          },
          bundler_args: {
            type: :string
          }
        },
        keys: {
          rvm: {
            aliases: [
              :ruby
            ],
            only: {
              language: [
                'ruby'
              ]
            }
          },
          gemfile: {
            aliases: [
              :gemfiles
            ],
            only: {
              language: [
                'ruby'
              ]
            }
          },
          jdk: {
            only: {
              language: [
                'ruby'
              ]
            },
            except: {
              os: [
                'osx'
              ]
            }
          },
          bundler_args: {
            only: {
              language: [
                'ruby'
              ]
            }
          }
        },
        normal: true
      )
    end
  end

  describe 'schema' do
    subject { described_class.new.schema }

    it do
      should eq(
        '$ref': '#/definitions/language/ruby'
      )
    end
  end
end

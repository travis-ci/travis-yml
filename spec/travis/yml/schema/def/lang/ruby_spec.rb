describe Travis::Yml::Schema::Def::Ruby, 'schema' do
  subject { Travis::Yml.schema[:definitions][:language][:ruby] }

  # it { puts JSON.pretty_generate(subject) }

  it do
    should eq(
      '$id': :language_ruby,
        title: 'Language Ruby',
        type: :object,
        properties: {
          rvm: {
            '$ref': '#/definitions/type/strs',
            aliases: [
              :ruby,
              :rbenv
            ],
            flags: [
              :expand
            ],
            only: {
              language: [
                'ruby'
              ]
            }
          },
          gemfile: {
            '$ref': '#/definitions/type/strs',
            aliases: [
              :gemfiles
            ],
            flags: [
              :expand
            ],
            only: {
              language: [
                'ruby'
              ]
            }
          },
          jdk: {
            '$ref': '#/definitions/type/jdks',
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
            type: :string,
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

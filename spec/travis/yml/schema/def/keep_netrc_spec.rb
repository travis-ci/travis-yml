# spec/travis/yml/schema/def/keep_netrc_spec.rb

describe Travis::Yml::Schema::Def::KeepNetrc do
  subject { Travis::Yml.schema[:definitions][:type][:keep_netrc] }

  # it { puts JSON.pretty_generate(subject) } # Uncomment to debug schema

  it do
    should include(
      '$id': :keep_netrc,
      title: 'Keep Netrc',
      summary: 'Whether to retain the `.netrc` file after the build',
      example: 'true',
      anyOf: [
        {
          type: :boolean,
          normal: true
        }
      ]
    )
  end
end
